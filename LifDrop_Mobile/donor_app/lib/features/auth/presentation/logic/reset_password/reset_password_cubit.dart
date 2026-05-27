import 'package:donor_app/core/networking/api_result.dart';
import 'package:donor_app/features/auth/domain/repositories/auth_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'reset_password_state.dart';

class ResetPasswordCubit extends Cubit<ResetPasswordState> {
  final AuthRepository _authRepository;

  ResetPasswordCubit(this._authRepository) : super(const ResetPasswordState());

  Future<void> resetPassword(
    String email,
    String code,
    String newPassword,
  ) async {
    emit(state.copyWith(status: ResetPasswordStatus.loading));

    final result = await _authRepository.resetPassword(
      email,
      code,
      newPassword,
    );
    result.when(
      success: (_) => emit(state.copyWith(status: ResetPasswordStatus.success)),
      failure: (error) => emit(
        state.copyWith(status: ResetPasswordStatus.failure, error: error),
      ),
    );
  }
}
