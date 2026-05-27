import 'package:donor_app/core/networking/api_result.dart';
import 'package:donor_app/core/networking/paged_response.dart';
import 'package:donor_app/features/donation_history/domain/entities/donation_history_entity.dart';

abstract class DonationHistoryRepository {
  Future<ApiResult<PagedResponse<DonationHistoryEntity>>> getHistory({
    required int pageNumber,
    required int pageSize,
  });
}
