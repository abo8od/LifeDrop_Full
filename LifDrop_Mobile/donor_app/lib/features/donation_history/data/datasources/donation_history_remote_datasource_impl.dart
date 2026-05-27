import 'package:dio/dio.dart';
import 'package:donor_app/core/mixins/safe_api_call_mixin.dart';
import 'package:donor_app/core/networking/api_response.dart';
import 'package:donor_app/core/networking/api_result.dart';
import 'package:donor_app/core/networking/paged_response.dart';
import 'package:donor_app/features/donation_history/data/datasources/donation_history_constants.dart';
import 'package:donor_app/features/donation_history/data/models/donation_history_model.dart';

abstract class DonationHistoryRemoteDatasource {
  Future<ApiResult<PagedResponse<DonationHistoryModel>>> getHistory({
    required int pageNumber,
    required int pageSize,
  });
}

class DonationHistoryRemoteDatasourceImpl
    extends DonationHistoryRemoteDatasource
    with SafeApiCallMixin {
  DonationHistoryRemoteDatasourceImpl(this._dio);

  final Dio _dio;

  @override
  Future<ApiResult<PagedResponse<DonationHistoryModel>>> getHistory({
    required int pageNumber,
    required int pageSize,
  }) {
    return safeApiCall('getDonationHistory', () async {
      final response = await _dio.get(
        DonationHistoryConstants.history,
        queryParameters: {'PageNumber': pageNumber, 'PageSize': pageSize},
      );

      final result = ApiResponse<PagedResponse<DonationHistoryModel>>.fromJson(
        response.data,
        (json) => PagedResponse<DonationHistoryModel>.fromJson(
          json as Map<String, dynamic>,
          (item) => DonationHistoryModel.fromJson(item as Map<String, dynamic>),
        ),
      );

      return result.data;
    });
  }
}
