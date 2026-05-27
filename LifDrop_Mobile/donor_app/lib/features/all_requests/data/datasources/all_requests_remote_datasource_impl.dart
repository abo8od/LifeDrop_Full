import 'package:dio/dio.dart';
import 'package:donor_app/core/mixins/safe_api_call_mixin.dart';
import 'package:donor_app/core/networking/api_response.dart';
import 'package:donor_app/core/networking/api_result.dart';
import 'package:donor_app/core/networking/paged_response.dart';
import 'package:donor_app/features/all_requests/data/datasources/all_requests_constants.dart';
import 'package:donor_app/features/all_requests/data/models/donation_request_feed_model.dart';

abstract class AllRequestsRemoteDatasource {
  Future<ApiResult<PagedResponse<DonationRequestFeedModel>>> getRequests({
    required int pageNumber,
    required int pageSize,
    String? searchTerm,
    int? urgency,
  });
}

class AllRequestsRemoteDatasourceImpl extends AllRequestsRemoteDatasource
    with SafeApiCallMixin {
  AllRequestsRemoteDatasourceImpl(this._dio);

  final Dio _dio;

  @override
  Future<ApiResult<PagedResponse<DonationRequestFeedModel>>> getRequests({
    required int pageNumber,
    required int pageSize,
    String? searchTerm,
    int? urgency,
  }) {
    return safeApiCall('getDonationRequestsFeed', () async {
      final trimmedSearchTerm = searchTerm?.trim();
      final queryParameters = <String, dynamic>{
        'PageNumber': pageNumber,
        'PageSize': pageSize,
      };

      if (trimmedSearchTerm != null && trimmedSearchTerm.isNotEmpty) {
        queryParameters['SearchTerm'] = trimmedSearchTerm;
      }
      if (urgency != null) {
        queryParameters['Urgency'] = urgency;
      }

      final response = await _dio.get(
        AllRequestsConstants.feed,
        queryParameters: queryParameters,
      );

      final result =
          ApiResponse<PagedResponse<DonationRequestFeedModel>>.fromJson(
            response.data,
            (json) => PagedResponse<DonationRequestFeedModel>.fromJson(
              json as Map<String, dynamic>,
              (item) => DonationRequestFeedModel.fromJson(
                item as Map<String, dynamic>,
              ),
            ),
          );

      return result.data;
    });
  }
}
