import 'package:donor_app/core/networking/api_error_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'device_token_state.freezed.dart';

@freezed
sealed class DeviceTokenState with _$DeviceTokenState {
  const factory DeviceTokenState.initial() = _DeviceTokenInitial;
  const factory DeviceTokenState.loading() = DeviceTokenLoading;
  const factory DeviceTokenState.registered() = DeviceTokenRegistered;
  const factory DeviceTokenState.unregistered() = DeviceTokenUnregistered;
  const factory DeviceTokenState.error(ApiErrorModel error) = DeviceTokenError;
}
