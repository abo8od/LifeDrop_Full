import 'package:donor_app/core/networking/api_result.dart';
import 'package:donor_app/core/networking/paged_response.dart';
import 'package:donor_app/features/all_requests/data/datasources/all_requests_remote_datasource_impl.dart';
import 'package:donor_app/features/all_requests/domain/entities/donation_request_feed_entity.dart';
import 'package:donor_app/features/all_requests/domain/repositories/all_requests_repository.dart';

class AllRequestsRepositoryImpl extends AllRequestsRepository {
  AllRequestsRepositoryImpl(this._remoteDatasource);

  final AllRequestsRemoteDatasource _remoteDatasource;

  @override
  Future<ApiResult<PagedResponse<DonationRequestFeedEntity>>> getRequests({
    required int pageNumber,
    required int pageSize,
    String? searchTerm,
    int? urgency,
  }) async {
    final result = await _remoteDatasource.getRequests(
      pageNumber: pageNumber,
      pageSize: pageSize,
      searchTerm: searchTerm,
      urgency: urgency,
    );

    return result.when(
      success: (page) => ApiResult.success(
        PagedResponse<DonationRequestFeedEntity>(
          data: page.data,
          pageNumber: page.pageNumber,
          pageSize: page.pageSize,
          totalCount: page.totalCount,
          totalPages: page.totalPages,
          hasPreviousPage: page.hasPreviousPage,
          hasNextPage: page.hasNextPage,
        ),
      ),
      failure: (error) => ApiResult.failure(error),
    );
  }
}
