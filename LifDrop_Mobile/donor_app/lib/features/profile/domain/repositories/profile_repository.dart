import 'package:donor_app/core/networking/api_result.dart';
import 'package:donor_app/core/entities/districts_entity.dart';
import 'package:donor_app/core/entities/governorate_entity.dart';
import 'package:donor_app/features/profile/data/requests/update_profile_request.dart';
import 'package:donor_app/features/profile/domain/entities/cooldown_entity.dart';
import 'package:donor_app/features/profile/domain/entities/updated_profile_response_entity.dart';
import 'package:donor_app/features/profile/domain/entities/user_entity.dart';

abstract class ProfileRepository {
  Future<ApiResult<UserEntity>> getProfile();
  Future<ApiResult<CooldownEntity>> getCooldownStatus();
  Future<ApiResult<UpdatedProfileResponseEntity>> updateProfile(
    UpdateProfileRequest request,
  );
  Future<ApiResult<List<GovernorateEntity>>> getGovernorates();
  Future<ApiResult<List<DistrictsEntity>>> getDistrictsByGovernorate(
    String governorateId,
  );
}
