import 'package:donor_app/core/networking/api_result.dart';
import 'package:donor_app/features/requests/data/datasource/requests_remote_datasource_impl.dart';
import 'package:donor_app/features/requests/data/requests/cancel_acceptance_request.dart';
import 'package:donor_app/features/requests/domain/entities/active_donation_entity.dart';
import 'package:donor_app/features/requests/domain/entities/donation_cancellation_reasons_entity.dart';
import 'package:donor_app/features/requests/domain/repository/requests_repository.dart';

class RequestsRepositoryImpl extends RequestsRepository {
  final RequestsRemoteDatasourceImpl _remoteDatasourceImpl;

  RequestsRepositoryImpl(this._remoteDatasourceImpl);

  @override
  Future<ApiResult<void>> cancelDonationAcceptance(
    String requestId,
    CancelAcceptanceRequest request,
  ) async {
    final result = await _remoteDatasourceImpl.cancelDonationAcceptance(
      requestId,
      request,
    );
    return result.when(
      success: (data) => ApiResult.success(null),
      failure: (error) => ApiResult.failure(error),
    );
  }

  @override
  Future<ApiResult<ActiveDonationEntity?>> getCurrentActiveDonation() async {
    final result = await _remoteDatasourceImpl.getCurrentActiveDonation();

    return result.when(
      success: (data) => ApiResult.success(data),
      failure: (error) => ApiResult.failure(error),
    );
  }

  @override
  Future<ApiResult<List<DonationCancellationReasonsEntity>>>
  getDonationCancellationReasons() async {
    final result = await _remoteDatasourceImpl.getDonationCancellationReasons();

    return result.when(
      success: (data) => ApiResult.success(data),
      failure: (error) => ApiResult.failure(error),
    );
  }
}
