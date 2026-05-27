import 'package:donor_app/core/enums/district_status.dart';
import 'package:donor_app/core/enums/governorate_status.dart';
import 'package:donor_app/core/networking/api_error_model.dart';
import 'package:donor_app/core/entities/districts_entity.dart';
import 'package:donor_app/core/entities/governorate_entity.dart';
import 'package:donor_app/features/profile/domain/entities/updated_profile_response_entity.dart';

enum EditProfileStatus { initial, loading, success, failure }

class EditProfileState {
  final EditProfileStatus status;
  final ApiErrorModel? error;
  final GovernoratesStatus governoratesStatus;
  final DistrictsStatus districtsStatus;
  final List<GovernorateEntity> governorates;
  final List<DistrictsEntity> districts;
  final UpdatedProfileResponseEntity? response;

  const EditProfileState({
    this.status = EditProfileStatus.initial,
    this.error,
    this.governoratesStatus = GovernoratesStatus.initial,
    this.districtsStatus = DistrictsStatus.initial,
    this.governorates = const [],
    this.districts = const [],
    this.response,
  });

  EditProfileState copyWith({
    EditProfileStatus? status,
    ApiErrorModel? error,
    GovernoratesStatus? governoratesStatus,
    DistrictsStatus? districtsStatus,
    List<GovernorateEntity>? governorates,
    List<DistrictsEntity>? districts,
    UpdatedProfileResponseEntity? response,
  }) {
    return EditProfileState(
      status: status ?? this.status,
      error: error ?? this.error,
      governoratesStatus: governoratesStatus ?? this.governoratesStatus,
      districtsStatus: districtsStatus ?? this.districtsStatus,
      governorates: governorates ?? this.governorates,
      districts: districts ?? this.districts,
      response: response ?? this.response,
    );
  }
}
