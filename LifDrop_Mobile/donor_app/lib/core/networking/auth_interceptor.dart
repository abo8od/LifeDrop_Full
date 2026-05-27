import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:donor_app/core/di/injection_container.dart';
import 'package:donor_app/core/helpers/constants.dart';
import 'package:donor_app/core/helpers/shared_pref_helper.dart';
import 'package:donor_app/core/networking/api_result.dart';
import 'package:donor_app/core/networking/dio_factory.dart';
import 'package:donor_app/core/routing/routes.dart';
import 'package:donor_app/features/auth/data/datasources/auth_constants.dart';
import 'package:donor_app/features/auth/domain/repositories/auth_repository.dart';

class AuthInterceptor extends QueuedInterceptor {
  final Dio _dio;
  bool isRefreshing = false;

  AuthInterceptor(this._dio);

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    if (err.response?.statusCode == 401 && !_shouldSkipRefresh(err)) {
      try {
        if (!isRefreshing) {
          isRefreshing = true;

          final newAccessToken = await _refreshToken();
          if (newAccessToken == null) {
            await _clearTokensAndLogout();
            return handler.reject(err);
          }

          DioFactory.setTokenIntoHeaderAfterLogin(newAccessToken);
          isRefreshing = false;
        } else {
          while (isRefreshing) {
            await Future.delayed(const Duration(milliseconds: 100));
          }
        }

        final token = await SharedPrefHelper.getSecuredString(
          SharedPrefKeys.accessToken,
        );
        // Update header for the current failed request
        err.requestOptions.headers['Authorization'] = 'Bearer $token';

        final response = await _dio.fetch(err.requestOptions);
        return handler.resolve(response);
      } catch (e) {
        isRefreshing = false;
        // Refresh itself failed
        await _clearTokensAndLogout();
        handler.reject(err);
      } finally {
        isRefreshing = false; // always unlock
      }
    } else {
      handler.next(err); // not 401, pass error normally
    }
  }

  bool _shouldSkipRefresh(DioException err) {
    final requestPath = err.requestOptions.uri.toString();
    return _publicEndpoints.any(requestPath.contains);
  }

  static const List<String> _publicEndpoints = [
    AuthConstants.login,
    AuthConstants.verifyOtp,
    AuthConstants.sendOtp,
    AuthConstants.resetPassword,
    AuthConstants.resendOtp,
    AuthConstants.refreshToken,
    AuthConstants.register,
    AuthConstants.verifyRegistration,
    AuthConstants.resendRegistrationOtp,
  ];

  Future<String?> _refreshToken() async {
    final oldAccessToken = await SharedPrefHelper.getSecuredString(
      SharedPrefKeys.accessToken,
    );
    final oldRefreshToken = await SharedPrefHelper.getSecuredString(
      SharedPrefKeys.refreshToken,
    );

    if (oldAccessToken.isEmpty || oldRefreshToken.isEmpty) return null;

    final result = await getIt<AuthRepository>().refreshToken(
      oldAccessToken,
      oldRefreshToken,
    );
    return result.when(
      success: (data) async {
        await _saveTokens(data.accessToken, data.refreshToken);
        return data.accessToken;
      },
      failure: (_) => null,
    );
  }

  Future<void> _saveTokens(String accessToken, String refreshToken) async {
    await SharedPrefHelper.setSecuredString(
      SharedPrefKeys.accessToken,
      accessToken,
    );
    await SharedPrefHelper.setSecuredString(
      SharedPrefKeys.refreshToken,
      refreshToken,
    );
  }

  Future<void> _clearTokensAndLogout() async {
    log('clearTokensAndLogout');
    await SharedPrefHelper.removeAllSecuredData();

    navigatorKey.currentState?.pushNamedAndRemoveUntil(
      Routes.login,
      (route) => false,
    );
  }
}
