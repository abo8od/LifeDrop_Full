import 'package:donor_app/core/networking/api_result.dart';
import 'package:donor_app/features/auth/domain/params/register_params.dart';
import 'package:donor_app/features/auth/domain/repositories/auth_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  final AuthRepository _authRepository;

  RegisterCubit(this._authRepository) : super(const RegisterState());

  Future<void> register(RegisterParams params) async {
    emit(state.copyWith(status: RegisterStatus.loading));

    final result = await _authRepository.register(params);
    result.when(
      success: (_) => emit(state.copyWith(status: RegisterStatus.success)),
      failure: (error) =>
          emit(state.copyWith(status: RegisterStatus.failure, error: error)),
    );
  }

  Future<void> getGovernorates() async {
    emit(state.copyWith(governoratesStatus: GovernoratesStatus.loading));

    final result = await _authRepository.getGovernorates();
    result.when(
      success: (governorates) => emit(
        state.copyWith(
          governoratesStatus: GovernoratesStatus.success,
          governorates: governorates,
        ),
      ),
      failure: (error) => emit(
        state.copyWith(
          governoratesStatus: GovernoratesStatus.failure,
          error: error,
        ),
      ),
    );
  }

  Future<void> getDistrictsByGovernorateId(String governorateId) async {
    emit(state.copyWith(districtsStatus: DistrictsStatus.loading));

    final result = await _authRepository.getDistrictsByGovernorate(
      governorateId,
    );
    result.when(
      success: (districts) => emit(
        state.copyWith(
          districtsStatus: DistrictsStatus.success,
          districts: districts,
        ),
      ),
      failure: (error) => emit(
        state.copyWith(districtsStatus: DistrictsStatus.failure, error: error),
      ),
    );
  }
}
