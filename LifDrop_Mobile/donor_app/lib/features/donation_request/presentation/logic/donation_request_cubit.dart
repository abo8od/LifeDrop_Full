import 'package:donor_app/core/networking/api_result.dart';
import 'package:donor_app/features/donation_request/domain/entities/request_details_entity.dart';
import 'package:donor_app/features/donation_request/domain/repositories/donation_request_repository.dart';
import 'package:donor_app/features/donation_request/presentation/logic/donation_request_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DonationRequestCubit extends Cubit<DonationRequestState> {
  final DonationRequestRepository _repository;

  DonationRequestCubit(this._repository)
    : super(const DonationRequestState.initial());

  Future<void> getRequestDetails(String requestId) async {
    emit(const DonationRequestState.detailsLoading());

    final result = await _repository.getRequestDetails(requestId);

    result.when(
      success: (request) => emit(DonationRequestState.detailsSuccess(request)),
      failure: (error) => emit(DonationRequestState.detailsError(error)),
    );
  }

  Future<void> acceptRequest(RequestDetailsEntity request) async {
    emit(DonationRequestState.acceptLoading(request));

    final result = await _repository.acceptRequest(request.requestId);

    result.when(
      success: (acceptance) =>
          emit(DonationRequestState.acceptSuccess(acceptance, request)),
      failure: (error) =>
          emit(DonationRequestState.acceptError(error, request)),
    );
  }
}
