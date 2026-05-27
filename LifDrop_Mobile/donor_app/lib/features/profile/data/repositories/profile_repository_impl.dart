import 'package:donor_app/core/networking/api_result.dart';
import 'package:donor_app/core/entities/districts_entity.dart';
import 'package:donor_app/core/entities/governorate_entity.dart';
import 'package:donor_app/features/profile/data/datasources/profile_remote_datasource_impl.dart';
import 'package:donor_app/features/profile/data/requests/update_profile_request.dart';
import 'package:donor_app/features/profile/domain/entities/cooldown_entity.dart';
import 'package:donor_app/features/profile/domain/entities/updated_profile_response_entity.dart';
import 'package:donor_app/features/profile/domain/entities/user_entity.dart';
import 'package:donor_app/features/profile/domain/repositories/profile_repository.dart';

class ProfileRepositoryImpl extends ProfileRepository {
  final ProfileRemoteDatasource _remoteDatasource;

  ProfileRepositoryImpl(this._remoteDatasource);

  @override
  Future<ApiResult<CooldownEntity>> getCooldownStatus() {
    return _remoteDatasource.getCooldownStatus();
  }

  @override
  Future<ApiResult<UserEntity>> getProfile() {
    return _remoteDatasource.getProfile();
  }

  @override
  Future<ApiResult<UpdatedProfileResponseEntity>> updateProfile(
    UpdateProfileRequest request,
  ) {
    return _remoteDatasource.updateProfile(request);
  }

  @override
  Future<ApiResult<List<DistrictsEntity>>> getDistrictsByGovernorate(
    String governorateId,
  ) async {
    final result = await _remoteDatasource.getDistrictsByGovernorateId(
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
    final result = await _remoteDatasource.getGovernorates();
    return result.when(
      success: (response) {
        return ApiResult.success(response);
      },
      failure: (error) => ApiResult.failure(error),
    );
  }
}
