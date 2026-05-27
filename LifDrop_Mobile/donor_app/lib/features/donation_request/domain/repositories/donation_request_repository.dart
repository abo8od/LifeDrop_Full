import 'package:donor_app/core/networking/api_result.dart';
import 'package:donor_app/features/donation_request/domain/entities/acceptance_entity.dart';
import 'package:donor_app/features/donation_request/domain/entities/request_details_entity.dart';

abstract class DonationRequestRepository {
  Future<ApiResult<RequestDetailsEntity>> getRequestDetails(String requestId);

  Future<ApiResult<AcceptanceEntity>> acceptRequest(String requestId);
}
