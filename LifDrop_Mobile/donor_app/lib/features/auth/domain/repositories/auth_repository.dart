import 'package:donor_app/core/networking/api_result.dart';
import 'package:donor_app/core/entities/districts_entity.dart';
import 'package:donor_app/core/entities/governorate_entity.dart';
import '../entities/token_entity.dart';
import '../params/register_params.dart';

abstract class AuthRepository {
  Future<ApiResult<TokenEntity>> login(String email, String password);
  Future<ApiResult<TokenEntity>> refreshToken(
    String accessToken,
    String refreshToken,
  );
  Future<ApiResult<void>> register(RegisterParams params);
  Future<ApiResult<List<GovernorateEntity>>> getGovernorates();
  Future<ApiResult<List<DistrictsEntity>>> getDistrictsByGovernorate(
    String governorateId,
  );
  Future<ApiResult<void>> verifyOtp(String email, String otp);
  Future<ApiResult<void>> verifyRegistration(String email, String code);
  Future<ApiResult<void>> sendOtp(String email);
  Future<ApiResult<void>> resendOtp(String email);
  Future<ApiResult<void>> resendRegistrationOtp(String email);
  Future<ApiResult<void>> resetPassword(
    String email,
    String code,
    String newPassword,
  );
}
