import 'package:donor_app/core/networking/api_error_model.dart';

enum OtpStatus { initial, loading, verified, resent, failure }

class OtpState {
  final OtpStatus status;
  final ApiErrorModel? error;

  const OtpState({
    this.status = OtpStatus.initial,
    this.error,
  });

  OtpState copyWith({
    OtpStatus? status,
    ApiErrorModel? error,
  }) {
    return OtpState(
      status: status ?? this.status,
      error: error ?? this.error,
    );
  }
}
