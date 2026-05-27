import 'package:donor_app/core/networking/api_result.dart';
import 'package:donor_app/features/requests/data/requests/cancel_acceptance_request.dart';
import 'package:donor_app/features/requests/domain/entities/active_donation_entity.dart';
import 'package:donor_app/features/requests/domain/entities/donation_cancellation_reasons_entity.dart';

abstract class RequestsRepository {
  Future<ApiResult<ActiveDonationEntity?>> getCurrentActiveDonation();
  Future<ApiResult<List<DonationCancellationReasonsEntity>>>
  getDonationCancellationReasons();
  Future<ApiResult<void>> cancelDonationAcceptance(
    String requestId,
    CancelAcceptanceRequest request,
  );
}
