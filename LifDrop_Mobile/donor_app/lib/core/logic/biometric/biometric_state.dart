import 'package:freezed_annotation/freezed_annotation.dart';

part 'biometric_state.freezed.dart';

@freezed
sealed class BiometricState with _$BiometricState {
  const factory BiometricState({required bool isEnabled}) = _BiometricState;
}
