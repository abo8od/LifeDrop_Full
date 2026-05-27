import 'package:donor_app/core/networking/api_result.dart';
import 'package:donor_app/features/donation_request/data/datasources/donation_request_remote_datasource_impl.dart';
import 'package:donor_app/features/donation_request/domain/entities/acceptance_entity.dart';
import 'package:donor_app/features/donation_request/domain/entities/request_details_entity.dart';
import 'package:donor_app/features/donation_request/domain/repositories/donation_request_repository.dart';

class DonationRequestRepositoryImpl extends DonationRequestRepository {
  final DonationRequestRemoteDatasource _remoteDatasource;

  DonationRequestRepositoryImpl(this._remoteDatasource);

  @override
  Future<ApiResult<RequestDetailsEntity>> getRequestDetails(
    String requestId,
  ) async {
    final result = await _remoteDatasource.getRequestDetails(requestId);

    return result.when(
      success: (data) => ApiResult.success(data),
      failure: (error) => ApiResult.failure(error),
    );
  }

  @override
  Future<ApiResult<AcceptanceEntity>> acceptRequest(String requestId) async {
    final result = await _remoteDatasource.acceptRequest(requestId);

    return result.when(
      success: (data) => ApiResult.success(data),
      failure: (error) => ApiResult.failure(error),
    );
  }
}
