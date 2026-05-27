import 'package:donor_app/core/networking/api_error_model.dart';
import 'package:donor_app/features/requests/domain/entities/active_donation_entity.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'active_donation_state.freezed.dart';

@freezed
class ActiveDonationState with _$ActiveDonationState {
  const factory ActiveDonationState.initial() = _ActiveDonationInitial;

  const factory ActiveDonationState.loading() = ActiveDonationLoading;
  const factory ActiveDonationState.success(ActiveDonationEntity donation) =
      ActiveDonationSuccess;
  const factory ActiveDonationState.empty() =
      ActiveDonationEmpty; // no active donation
  const factory ActiveDonationState.error(ApiErrorModel error) =
      ActiveDonationError;
}
