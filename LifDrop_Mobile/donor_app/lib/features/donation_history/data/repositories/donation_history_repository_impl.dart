import 'package:donor_app/core/networking/api_result.dart';
import 'package:donor_app/core/networking/paged_response.dart';
import 'package:donor_app/features/donation_history/data/datasources/donation_history_remote_datasource_impl.dart';
import 'package:donor_app/features/donation_history/domain/entities/donation_history_entity.dart';
import 'package:donor_app/features/donation_history/domain/repositories/donation_history_repository.dart';

class DonationHistoryRepositoryImpl extends DonationHistoryRepository {
  DonationHistoryRepositoryImpl(this._remoteDatasource);

  final DonationHistoryRemoteDatasource _remoteDatasource;

  @override
  Future<ApiResult<PagedResponse<DonationHistoryEntity>>> getHistory({
    required int pageNumber,
    required int pageSize,
  }) async {
    final result = await _remoteDatasource.getHistory(
      pageNumber: pageNumber,
      pageSize: pageSize,
    );

    return result.when(
      success: (page) => ApiResult.success(
        PagedResponse<DonationHistoryEntity>(
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
