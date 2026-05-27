import 'package:donor_app/core/networking/api_error_model.dart';

enum ResetPasswordStatus { initial, loading, success, failure }

class ResetPasswordState {
  final ResetPasswordStatus status;
  final ApiErrorModel? error;

  const ResetPasswordState({
    this.status = ResetPasswordStatus.initial,
    this.error,
  });

  ResetPasswordState copyWith({
    ResetPasswordStatus? status,
    ApiErrorModel? error,
  }) {
    return ResetPasswordState(
      status: status ?? this.status,
      error: error ?? this.error,
    );
  }
}
