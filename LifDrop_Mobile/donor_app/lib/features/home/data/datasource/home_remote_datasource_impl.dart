import 'package:dio/dio.dart';
import 'package:donor_app/core/mixins/safe_api_call_mixin.dart';
import 'package:donor_app/core/networking/api_response.dart';
import 'package:donor_app/core/networking/api_result.dart';
import 'package:donor_app/features/home/data/datasource/home_constants.dart';
import 'package:donor_app/features/home/data/models/home_data_model.dart';

abstract class HomeRemoteDatasource {
  Future<ApiResult<HomeDataModel>> getHomeData();
}

class HomeRemoteDatasourceImpl extends HomeRemoteDatasource
    with SafeApiCallMixin {
  final Dio _dio;

  HomeRemoteDatasourceImpl(this._dio);

  @override
  Future<ApiResult<HomeDataModel>> getHomeData() {
    return safeApiCall('getHomeData', () async {
      final response = await _dio.get(HomeConstants.home);

      final result = ApiResponse.fromJson(
        response.data,
        (json) => HomeDataModel.fromJson(json as Map<String, dynamic>),
      );

      return result.data;
    });
  }
}
