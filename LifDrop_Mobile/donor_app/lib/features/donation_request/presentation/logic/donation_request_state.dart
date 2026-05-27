import 'package:donor_app/core/networking/api_error_model.dart';
import 'package:donor_app/features/donation_request/domain/entities/acceptance_entity.dart';
import 'package:donor_app/features/donation_request/domain/entities/request_details_entity.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'donation_request_state.freezed.dart';

@freezed
class DonationRequestState with _$DonationRequestState {
  const factory DonationRequestState.initial() = _DonationRequestInitial;
  const factory DonationRequestState.detailsLoading() =
      DonationRequestDetailsLoading;
  const factory DonationRequestState.detailsSuccess(
    RequestDetailsEntity request,
  ) = DonationRequestDetailsSuccess;
  const factory DonationRequestState.detailsError(ApiErrorModel error) =
      DonationRequestDetailsError;
  const factory DonationRequestState.acceptLoading(
    RequestDetailsEntity request,
  ) = DonationRequestAcceptLoading;
  const factory DonationRequestState.acceptSuccess(
    AcceptanceEntity acceptance,
    RequestDetailsEntity request,
  ) = DonationRequestAcceptSuccess;
  const factory DonationRequestState.acceptError(
    ApiErrorModel error,
    RequestDetailsEntity request,
  ) = DonationRequestAcceptError;
}
