import 'package:donor_app/core/networking/api_error_model.dart';
import 'package:donor_app/features/home/domain/entities/home_data_entity.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'home_state.freezed.dart';

@freezed
class HomeState with _$HomeState {
  const factory HomeState.initial() = _HomeInitial;
  const factory HomeState.loading() = HomeLoading;
  const factory HomeState.success(HomeDataEntity data) = HomeSuccess;
  const factory HomeState.error(ApiErrorModel error) = HomeError;
  const factory HomeState.biometricPromptRequired() =
      HomeBiometricPromptRequired;
}
