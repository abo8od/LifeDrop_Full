import 'package:donor_app/core/networking/api_result.dart';
import 'package:donor_app/core/networking/paged_response.dart';
import 'package:donor_app/features/all_requests/domain/entities/donation_request_feed_entity.dart';

abstract class AllRequestsRepository {
  Future<ApiResult<PagedResponse<DonationRequestFeedEntity>>> getRequests({
    required int pageNumber,
    required int pageSize,
    String? searchTerm,
    int? urgency,
  });
}
