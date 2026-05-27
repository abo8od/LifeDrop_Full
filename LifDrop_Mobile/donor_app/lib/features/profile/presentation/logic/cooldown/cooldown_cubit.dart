import 'package:donor_app/core/networking/api_result.dart';
import 'package:donor_app/features/profile/domain/repositories/profile_repository.dart';
import 'package:donor_app/features/profile/presentation/logic/cooldown/cooldown_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CooldownCubit extends Cubit<CooldownState> {
  final ProfileRepository _repository;
  CooldownCubit(this._repository) : super(const CooldownState.initial());

  Future<void> getCooldownStatus() async {
    emit(const CooldownState.loading());
    final result = await _repository.getCooldownStatus();
    if (isClosed) return;

    result.when(
      success: (data) => emit(CooldownState.success(data)),
      failure: (error) => emit(CooldownState.error(error)),
    );
  }
}
