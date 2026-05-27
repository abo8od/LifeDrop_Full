import 'package:donor_app/core/networking/api_result.dart';
import 'package:donor_app/features/auth/domain/repositories/auth_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'forgot_password_state.dart';

class ForgotPasswordCubit extends Cubit<ForgotPasswordState> {
  final AuthRepository _authRepository;

  ForgotPasswordCubit(this._authRepository)
    : super(const ForgotPasswordState());

  Future<void> sendOtp(String email) async {
    emit(state.copyWith(status: ForgotPasswordStatus.loading));

    final result = await _authRepository.sendOtp(email);
    result.when(
      success: (_) =>
          emit(state.copyWith(status: ForgotPasswordStatus.success)),
      failure: (error) => emit(
        state.copyWith(status: ForgotPasswordStatus.failure, error: error),
      ),
    );
  }
}
