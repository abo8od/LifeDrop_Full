import 'package:dio/dio.dart';
import 'package:donor_app/core/mixins/safe_api_call_mixin.dart';
import 'package:donor_app/features/auth/data/datasources/auth_constants.dart';
import 'package:donor_app/core/networking/api_response.dart';
import 'package:donor_app/core/networking/api_result.dart';
import 'package:donor_app/core/models/districts_model.dart';
import 'package:donor_app/core/models/governorate_model.dart';
import '../../domain/params/register_params.dart';
import '../models/token_model.dart';

abstract class _AuthRemoteDataSource {
  Future<ApiResult<TokenModel>> login(String email, String password);
  Future<ApiResult<TokenModel>> refreshToken(
    String accessToken,
    String refreshToken,
  );
  Future<ApiResult<void>> register(RegisterParams params);
  Future<ApiResult<void>> verifyOtp(String email, String code);
  Future<ApiResult<void>> verifyRegistration(String email, String code);
  Future<ApiResult<void>> sendOtp(String email);
  Future<ApiResult<void>> resendOtp(String email);
  Future<ApiResult<void>> resendRegistrationOtp(String email);
  Future<ApiResult<void>> resetPassword({
    required String email,
    required String code,
    required String newPassword,
  });
  Future<ApiResult<List<GovernorateModel>>> getGovernorates();
  Future<ApiResult<List<DistrictsModel>>> getDistrictsByGovernorateId(
    String governorateId,
  );
}

class AuthRemoteDataSourceImpl extends _AuthRemoteDataSource
    with SafeApiCallMixin {
  final Dio _dio;

  AuthRemoteDataSourceImpl(this._dio);

  @override
  Future<ApiResult<TokenModel>> login(String email, String password) {
    return safeApiCall('login', () async {
      final response = await _dio.post(
        AuthConstants.login,
        data: {'email': email, 'password': password},
      );
      final result = ApiResponse<TokenModel>.fromJson(
        response.data,
        (json) => TokenModel.fromJson(json as Map<String, dynamic>),
      );
      return result.data;
    });
  }

  @override
  Future<ApiResult<void>> register(RegisterParams params) {
    return safeApiCall('register', () async {
      await _dio.post(AuthConstants.register, data: params.toJson());
    });
  }

  @override
  Future<ApiResult<void>> verifyOtp(String email, String code) {
    return safeApiCall('verifyOtp', () async {
      await _dio.post(
        AuthConstants.verifyOtp,
        data: {'email': email, 'code': code},
      );
    });
  }

  @override
  Future<ApiResult<void>> verifyRegistration(String email, String code) {
    return safeApiCall('verifyRegistration', () async {
      await _dio.post(
        AuthConstants.verifyRegistration,
        data: {'email': email, 'code': code},
      );
    });
  }

  @override
  Future<ApiResult<void>> sendOtp(String email) {
    return safeApiCall('sendOtp', () async {
      await _dio.post(AuthConstants.sendOtp, data: {'email': email});
    });
  }

  @override
  Future<ApiResult<void>> resendOtp(String email) {
    return safeApiCall('resendOtp', () async {
      await _dio.post(AuthConstants.resendOtp, data: {'email': email});
    });
  }

  @override
  Future<ApiResult<TokenModel>> refreshToken(
    String accessToken,
    String refreshToken,
  ) {
    return safeApiCall('refreshToken', () async {
      final response = await _dio.post(
        AuthConstants.refreshToken,
        data: {'accessToken': accessToken, 'refreshToken': refreshToken},
      );
      final result = ApiResponse<TokenModel>.fromJson(
        response.data,
        (json) => TokenModel.fromJson(json as Map<String, dynamic>),
      );
      return result.data;
    });
  }

  @override
  Future<ApiResult<void>> resendRegistrationOtp(String email) {
    return safeApiCall('resendRegistrationOtp', () async {
      await _dio.post(
        AuthConstants.resendRegistrationOtp,
        data: {'email': email},
      );
    });
  }

  @override
  Future<ApiResult<void>> resetPassword({
    required String email,
    required String code,
    required String newPassword,
  }) {
    return safeApiCall('resetPassword', () async {
      await _dio.post(
        AuthConstants.resetPassword,
        data: {'email': email, 'code': code, 'newPassword': newPassword},
      );
    });
  }

  @override
  Future<ApiResult<List<GovernorateModel>>> getGovernorates() {
    return safeApiCall('getGovernorates', () async {
      final response = await _dio.get(AuthConstants.governorates);
      final result = ApiResponse<List<GovernorateModel>>.fromJson(
        response.data,
        (data) => List.from(data as List)
            .map(
              (json) => GovernorateModel.fromJson(json as Map<String, dynamic>),
            )
            .toList(),
      );
      return result.data;
    });
  }

  @override
  Future<ApiResult<List<DistrictsModel>>> getDistrictsByGovernorateId(
    String governorateId,
  ) {
    return safeApiCall('getDistrictsByGovernorateId', () async {
      final response = await _dio.get(AuthConstants.districts(governorateId));
      final result = ApiResponse<List<DistrictsModel>>.fromJson(
        response.data,
        (data) => List.from(
          data as List,
        ).map((json) => DistrictsModel.fromJson(json)).toList(),
      );
      return result.data;
    });
  }
}
