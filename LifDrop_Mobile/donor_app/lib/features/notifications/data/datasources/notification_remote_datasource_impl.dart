import 'package:dio/dio.dart';
import 'package:donor_app/core/mixins/safe_api_call_mixin.dart';
import 'package:donor_app/core/networking/api_result.dart';
import 'package:donor_app/features/notifications/data/datasources/notification_constants.dart';
import 'package:donor_app/features/notifications/data/models/device_token_request_model.dart';
import 'package:donor_app/features/notifications/domain/params/register_device_token_params.dart';

abstract class NotificationRemoteDatasource {
  Future<ApiResult<void>> registerDeviceToken(RegisterDeviceTokenParams params);

  Future<ApiResult<void>> unregisterDeviceToken(String token);
}

class NotificationRemoteDatasourceImpl extends NotificationRemoteDatasource
    with SafeApiCallMixin {
  final Dio _dio;

  NotificationRemoteDatasourceImpl(this._dio);

  @override
  Future<ApiResult<void>> registerDeviceToken(
    RegisterDeviceTokenParams params,
  ) {
    return safeApiCall('registerDeviceToken', () async {
      final request = DeviceTokenRequestModel.fromParams(params);
      await _dio.post(
        NotificationConstants.deviceToken,
        data: request.toJson(),
      );
    });
  }

  @override
  Future<ApiResult<void>> unregisterDeviceToken(String token) {
    return safeApiCall('unregisterDeviceToken', () async {
      final request = DeviceTokenRequestModel(token: token);
      await _dio.delete(
        NotificationConstants.deviceToken,
        data: request.toJson(),
      );
    });
  }
}
