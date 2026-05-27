import 'package:donor_app/core/networking/api_result.dart';
import 'package:donor_app/features/notifications/data/datasources/notification_remote_datasource_impl.dart';
import 'package:donor_app/features/notifications/domain/params/register_device_token_params.dart';
import 'package:donor_app/features/notifications/domain/repositories/notification_repository.dart';

class NotificationRepositoryImpl implements NotificationRepository {
  final NotificationRemoteDatasource _remoteDatasource;

  NotificationRepositoryImpl(this._remoteDatasource);

  @override
  Future<ApiResult<void>> registerDeviceToken(
    RegisterDeviceTokenParams params,
  ) {
    return _remoteDatasource.registerDeviceToken(params);
  }

  @override
  Future<ApiResult<void>> unregisterDeviceToken(String token) {
    return _remoteDatasource.unregisterDeviceToken(token);
  }
}
