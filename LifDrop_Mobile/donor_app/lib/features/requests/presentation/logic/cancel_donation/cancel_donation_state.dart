import 'package:donor_app/core/networking/api_error_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'cancel_donation_state.freezed.dart';

@freezed
class CancelDonationState with _$CancelDonationState {
  const factory CancelDonationState.initial() = _CancelDonationInitial;
  const factory CancelDonationState.loading() = CancelDonationLoading;
  const factory CancelDonationState.success() = CancelDonationSuccess;
  const factory CancelDonationState.error(ApiErrorModel error) =
      CancelDonationError;
}
