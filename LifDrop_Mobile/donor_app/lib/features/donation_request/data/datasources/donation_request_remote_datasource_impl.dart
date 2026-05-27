import 'package:dio/dio.dart';
import 'package:donor_app/core/mixins/safe_api_call_mixin.dart';
import 'package:donor_app/core/networking/api_response.dart';
import 'package:donor_app/core/networking/api_result.dart';
import 'package:donor_app/features/donation_request/data/datasources/donation_request_constants.dart';
import 'package:donor_app/features/donation_request/data/models/acceptance_model.dart';
import 'package:donor_app/features/donation_request/data/models/request_details_model.dart';
import 'package:uuid/uuid.dart';

abstract class DonationRequestRemoteDatasource {
  Future<ApiResult<RequestDetailsModel>> getRequestDetails(String requestId);

  Future<ApiResult<AcceptanceModel>> acceptRequest(String requestId);
}

class DonationRequestRemoteDatasourceImpl
    extends DonationRequestRemoteDatasource
    with SafeApiCallMixin {
  final Dio _dio;

  DonationRequestRemoteDatasourceImpl(this._dio);

  @override
  Future<ApiResult<RequestDetailsModel>> getRequestDetails(String requestId) {
    return safeApiCall('getRequestDetails', () async {
      final response = await _dio.get(
        DonationRequestConstants.requestDetails(requestId),
      );

      final result = ApiResponse<RequestDetailsModel>.fromJson(
        response.data,
        (json) => RequestDetailsModel.fromJson(json as Map<String, dynamic>),
      );

      return result.data;
    });
  }

  @override
  Future<ApiResult<AcceptanceModel>> acceptRequest(String requestId) {
    return safeApiCall('acceptRequest', () async {
      final response = await _dio.post(
        DonationRequestConstants.acceptRequest(requestId),
        options: Options(
          headers: {'X-Idempotency-Key': _createIdempotencyKey()},
        ),
      );

      final result = ApiResponse<AcceptanceModel>.fromJson(
        response.data,
        (json) => AcceptanceModel.fromJson(json as Map<String, dynamic>),
      );

      return result.data;
    });
  }

  String _createIdempotencyKey() {
    return const Uuid().v4();
  }
}
