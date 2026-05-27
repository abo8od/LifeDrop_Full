import 'package:donor_app/core/networking/api_result.dart';
import 'package:donor_app/features/requests/data/requests/cancel_acceptance_request.dart';
import 'package:donor_app/features/requests/domain/repository/requests_repository.dart';
import 'package:donor_app/features/requests/presentation/logic/cancel_donation/cancel_donation_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CancelDonationCubit extends Cubit<CancelDonationState> {
  final RequestsRepository _repository;
  CancelDonationCubit(this._repository)
    : super(const CancelDonationState.initial());

  Future<void> cancelDonation({
    required String requestId,
    required String reasonId,
    required String note,
  }) async {
    emit(const CancelDonationState.loading());
    final result = await _repository.cancelDonationAcceptance(
      requestId,
      CancelAcceptanceRequest(cancellationReasonId: reasonId, note: note),
    );

    result.when(
      success: (data) => emit(const CancelDonationState.success()),
      failure: (error) => emit(CancelDonationState.error(error)),
    );
  }
}
