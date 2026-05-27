import 'package:donor_app/core/networking/api_result.dart';
import 'package:donor_app/features/auth/domain/repositories/auth_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'otp_state.dart';

class OtpCubit extends Cubit<OtpState> {
  final AuthRepository _authRepository;

  OtpCubit(this._authRepository) : super(const OtpState());

  Future<void> verifyOtp(String email, String otp) async {
    emit(state.copyWith(status: OtpStatus.loading));

    final result = await _authRepository.verifyOtp(email, otp);
    result.when(
      success: (_) => emit(state.copyWith(status: OtpStatus.verified)),
      failure: (error) =>
          emit(state.copyWith(status: OtpStatus.failure, error: error)),
    );
  }

  Future<void> verifyRegistration(String email, String code) async {
    emit(state.copyWith(status: OtpStatus.loading));

    final result = await _authRepository.verifyRegistration(email, code);
    result.when(
      success: (_) => emit(state.copyWith(status: OtpStatus.verified)),
      failure: (error) =>
          emit(state.copyWith(status: OtpStatus.failure, error: error)),
    );
  }

  Future<void> resendOtp(String email) async {
    emit(state.copyWith(status: OtpStatus.loading));

    final result = await _authRepository.resendOtp(email);
    result.when(
      success: (_) => emit(state.copyWith(status: OtpStatus.resent)),
      failure: (error) =>
          emit(state.copyWith(status: OtpStatus.failure, error: error)),
    );
  }

  Future<void> resendRegistrationOtp(String email) async {
    emit(state.copyWith(status: OtpStatus.loading));

    final result = await _authRepository.resendRegistrationOtp(email);
    result.when(
      success: (_) => emit(state.copyWith(status: OtpStatus.resent)),
      failure: (error) =>
          emit(state.copyWith(status: OtpStatus.failure, error: error)),
    );
  }
}
