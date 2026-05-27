import 'package:donor_app/core/networking/api_error_model.dart';
import 'package:donor_app/features/profile/domain/entities/cooldown_entity.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'cooldown_state.freezed.dart';

@freezed
class CooldownState with _$CooldownState {
  const factory CooldownState.initial() = _CooldownInitial;
  const factory CooldownState.loading() = CooldownLoading;
  const factory CooldownState.success(CooldownEntity data) = CooldownSuccess;
  const factory CooldownState.error(ApiErrorModel error) = CooldownError;
}
