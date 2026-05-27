import 'package:donor_app/core/networking/api_result.dart';
import 'package:donor_app/features/profile/data/requests/update_profile_request.dart';
import 'package:donor_app/features/profile/domain/repositories/profile_repository.dart';
import 'package:donor_app/features/profile/presentation/logic/profile/profile_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileCubit extends Cubit<ProfileState> {
  final ProfileRepository _repository;

  ProfileCubit(this._repository) : super(const ProfileState.initial());

  Future<void> getUserProfile() async {
    emit(const ProfileState.loading());

    final result = await _repository.getProfile();
    if (isClosed) return;

    result.when(
      success: (data) => emit(ProfileState.success(data)),
      failure: (error) => emit(ProfileState.error(error)),
    );
  }

  Future<void> updateUserProfile(UpdateProfileRequest request) async {
    final currentUser = state.mapOrNull(
      success: (value) => value.user,
      updateSuccess: (value) => value.user,
    );

    if (currentUser != null) {
      emit(ProfileState.updating(currentUser));
    } else {
      emit(const ProfileState.loading());
    }

    final result = await _repository.updateProfile(request);
    if (isClosed) return;

    result.when(
      success: (data) {
        // re-fetch profile data
        getUserProfile();
      },
      failure: (error) => emit(ProfileState.error(error)),
    );
  }
}
