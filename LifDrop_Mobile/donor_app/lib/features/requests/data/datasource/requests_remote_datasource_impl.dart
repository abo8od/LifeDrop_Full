import 'package:dio/dio.dart';
import 'package:donor_app/core/networking/api_response.dart';
import 'package:donor_app/core/networking/api_result.dart';
import 'package:donor_app/core/mixins/safe_api_call_mixin.dart';
import 'package:donor_app/features/requests/data/datasource/requests_constants.dart';
import 'package:donor_app/features/requests/data/models/active_donation_model.dart';
import 'package:donor_app/features/requests/data/models/donation_cancellation_reasons_model.dart';
import 'package:donor_app/features/requests/data/requests/cancel_acceptance_request.dart';

abstract class _RequestsRemoteDatasource {
  Future<ApiResult<ActiveDonationModel?>> getCurrentActiveDonation();
  Future<ApiResult<List<DonationCancellationReasonsModel>>>
  getDonationCancellationReasons();
  Future<ApiResult<void>> cancelDonationAcceptance(
    String requestId,
    CancelAcceptanceRequest request,
  );
}

class RequestsRemoteDatasourceImpl extends _RequestsRemoteDatasource
    with SafeApiCallMixin {
  final Dio _dio;

  RequestsRemoteDatasourceImpl(this._dio);

  @override
  Future<ApiResult<ActiveDonationModel?>> getCurrentActiveDonation() async {
    return safeApiCall('getCurrentActiveDonation', () async {
      final response = await _dio.get(RequestsConstants.activeDonation);

      final result = ApiResponse<ActiveDonationModel>.fromJson(
        response.data,
        (json) => ActiveDonationModel.fromJson(json as Map<String, dynamic>),
      );

      return result.data;
    });
  }

  @override
  Future<ApiResult<void>> cancelDonationAcceptance(
    String requestId,
    CancelAcceptanceRequest request,
  ) {
    return safeApiCall('cancelDonationAcceptance', () async {
      await _dio.post(
        RequestsConstants.cancelDonationAcceptance(requestId),
        data: request.toJson(),
      );
    });
  }

  @override
  Future<ApiResult<List<DonationCancellationReasonsModel>>>
  getDonationCancellationReasons() {
    return safeApiCall('getDonationCancellationReasons', () async {
      final response = await _dio.get(RequestsConstants.reasonsCancellation);
      final result =
          ApiResponse<List<DonationCancellationReasonsModel>>.fromJson(
            response.data,
            (data) => List.from(data as List)
                .map(
                  (json) => DonationCancellationReasonsModel.fromJson(
                    json as Map<String, dynamic>,
                  ),
                )
                .toList(),
          );

      return result.data;
    });
  }
}
