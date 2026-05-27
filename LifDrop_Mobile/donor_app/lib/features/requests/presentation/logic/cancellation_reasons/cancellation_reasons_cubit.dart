import 'package:donor_app/core/networking/api_result.dart';
import 'package:donor_app/features/requests/domain/repository/requests_repository.dart';
import 'package:donor_app/features/requests/presentation/logic/cancellation_reasons/cancellation_reasons_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CancellationReasonsCubit extends Cubit<CancellationReasonsState> {
  final RequestsRepository _repository;
  CancellationReasonsCubit(this._repository)
    : super(CancellationReasonsState());

  Future<void> getCancellationReasons() async {
    emit(state.copyWith(status: .loading));

    final result = await _repository.getDonationCancellationReasons();
    result.when(
      success: (data) => emit(state.copyWith(status: .success, reasons: data)),
      failure: (error) => emit(state.copyWith(status: .failure, error: error)),
    );
  }
}
