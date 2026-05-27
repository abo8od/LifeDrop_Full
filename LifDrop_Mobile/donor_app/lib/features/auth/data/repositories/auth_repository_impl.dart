import 'package:donor_app/core/helpers/constants.dart';
import 'package:donor_app/core/helpers/shared_pref_helper.dart';
import 'package:donor_app/core/networking/api_result.dart';
import 'package:donor_app/core/networking/dio_factory.dart';
import 'package:donor_app/core/entities/districts_entity.dart';
import 'package:donor_app/core/entities/governorate_entity.dart';
import '../../domain/entities/token_entity.dart';
import '../../domain/params/register_params.dart';
import '../../domain/repositories/auth_repository.dart';
import '../datasources/auth_remote_datasource_impl.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSourceImpl _remoteDataSourceImpl;

  AuthRepositoryImpl(this._remoteDataSourceImpl);

  @override
  Future<ApiResult<TokenEntity>> login(String email, String password) async {
    final result = await _remoteDataSourceImpl.login(email, password);
    return result.when(
      success: (response) async {
        await _cacheAccess(response.accessToken, response.refreshToken);
        return ApiResult.success(response);
      },
      failure: (error) => ApiResult.failure(error),
    );
  }

  @override
  Future<ApiResult<void>> register(RegisterParams params) async {
    final result = await _remoteDataSourceImpl.register(params);
    return result.when(
      success: (response) {
        return ApiResult.success(response);
      },
      failure: (error) => ApiResult.failure(error),
    );
  }

  @override
  Future<ApiResult<void>> verifyOtp(String email, String otp) async {
    final result = await _remoteDataSourceImpl.verifyOtp(email, otp);
    return result.when(
      success: (response) {
        return ApiResult.success(null);
      },
      failure: (error) => ApiResult.failure(error),
    );
  }

  @override
  Future<ApiResult<void>> verifyRegistration(String email, String code) async {
    final result = await _remoteDataSourceImpl.verifyRegistration(email, code);
    return result.when(
      success: (response) {
        return ApiResult.success(null);
      },
      failure: (error) => ApiResult.failure(error),
    );
  }

  @override
  Future<ApiResult<void>> sendOtp(String email) async {
    final result = await _remoteDataSourceImpl.sendOtp(email);
    return result.when(
      success: (response) {
        return ApiResult.success(null);
      },
      failure: (error) => ApiResult.failure(error),
    );
  }

  @override
  Future<ApiResult<void>> resendOtp(String email) async {
    final result = await _remoteDataSourceImpl.resendOtp(email);
    return result.when(
      success: (response) {
        return ApiResult.success(null);
      },
      failure: (error) => ApiResult.failure(error),
    );
  }

  @override
  Future<ApiResult<void>> resendRegistrationOtp(String email) async {
    final result = await _remoteDataSourceImpl.resendRegistrationOtp(email);
    return result.when(
      success: (response) {
        return ApiResult.success(null);
      },
      failure: (error) => ApiResult.failure(error),
    );
  }

  @override
  Future<ApiResult<void>> resetPassword(
    String email,
    String code,
    String newPassword,
  ) async {
    final result = await _remoteDataSourceImpl.resetPassword(
      email: email,
      code: code,
      newPassword: newPassword,
    );
    return result.when(
      success: (response) {
        return ApiResult.success(null);
      },
      failure: (error) => ApiResult.failure(error),
    );
  }

  Future<void> _cacheAccess(String accessToken, String refreshToken) async {
    await SharedPrefHelper.setSecuredString(
      SharedPrefKeys.accessToken,
      accessToken,
    );
    await SharedPrefHelper.setSecuredString(
      SharedPrefKeys.refreshToken,
      refreshToken,
    );
    DioFactory.setTokenIntoHeaderAfterLogin(accessToken);
  }

  @override
  Future<ApiResult<List<DistrictsEntity>>> getDistrictsByGovernorate(
    String governorateId,
  ) async {
    final result = await _remoteDataSourceImpl.getDistrictsByGovernorateId(
      governorateId,
    );
    return result.when(
      success: (response) {
        return ApiResult.success(response);
      },
      failure: (error) => ApiResult.failure(error),
    );
  }

  @override
  Future<ApiResult<List<GovernorateEntity>>> getGovernorates() async {
    final result = await _remoteDataSourceImpl.getGovernorates();
    return result.when(
      success: (response) {
        return ApiResult.success(response);
      },
      failure: (error) => ApiResult.failure(error),
    );
  }

  @override
  Future<ApiResult<TokenEntity>> refreshToken(
    String accessToken,
    String refreshToken,
  ) async {
    final result = await _remoteDataSourceImpl.refreshToken(
      accessToken,
      refreshToken,
    );
    return result.when(
      success: (data) => ApiResult.success(data),
      failure: (error) => ApiResult.failure(error),
    );
  }
}
