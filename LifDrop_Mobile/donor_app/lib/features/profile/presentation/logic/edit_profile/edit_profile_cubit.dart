import 'package:donor_app/core/enums/district_status.dart';
import 'package:donor_app/core/enums/governorate_status.dart';
import 'package:donor_app/core/networking/api_result.dart';
import 'package:donor_app/features/profile/data/requests/update_profile_request.dart';
import 'package:donor_app/features/profile/domain/repositories/profile_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'edit_profile_state.dart';

class EditProfileCubit extends Cubit<EditProfileState> {
  final ProfileRepository _profileRepository;

  EditProfileCubit(this._profileRepository) : super(const EditProfileState());

  Future<void> getGovernorates() async {
    emit(state.copyWith(governoratesStatus: GovernoratesStatus.loading));

    final result = await _profileRepository.getGovernorates();
    result.when(
      success: (governorates) => emit(
        state.copyWith(
          governoratesStatus: GovernoratesStatus.success,
          governorates: governorates,
        ),
      ),
      failure: (error) => emit(
        state.copyWith(
          governoratesStatus: GovernoratesStatus.failure,
          error: error,
        ),
      ),
    );
  }

  Future<void> getDistrictsByGovernorateId(String governorateId) async {
    emit(state.copyWith(districtsStatus: DistrictsStatus.loading));

    final result = await _profileRepository.getDistrictsByGovernorate(
      governorateId,
    );
    result.when(
      success: (districts) => emit(
        state.copyWith(
          districtsStatus: DistrictsStatus.success,
          districts: districts,
        ),
      ),
      failure: (error) => emit(
        state.copyWith(districtsStatus: DistrictsStatus.failure, error: error),
      ),
    );
  }

  Future<void> updateProfile(UpdateProfileRequest request) async {
    emit(state.copyWith(status: EditProfileStatus.loading));

    final result = await _profileRepository.updateProfile(request);
    result.when(
      success: (response) => emit(
        state.copyWith(status: EditProfileStatus.success, response: response),
      ),
      failure: (error) =>
          emit(state.copyWith(status: EditProfileStatus.failure, error: error)),
    );
  }
}
