import 'package:donor_app/core/networking/api_error_model.dart';

enum ForgotPasswordStatus { initial, loading, success, failure }

class ForgotPasswordState {
  final ForgotPasswordStatus status;
  final ApiErrorModel? error;

  const ForgotPasswordState({
    this.status = ForgotPasswordStatus.initial,
    this.error,
  });

  ForgotPasswordState copyWith({
    ForgotPasswordStatus? status,
    ApiErrorModel? error,
  }) {
    return ForgotPasswordState(
      status: status ?? this.status,
      error: error ?? this.error,
    );
  }
}
