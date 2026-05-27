import 'package:donor_app/core/networking/api_result.dart';
import 'package:donor_app/features/notifications/domain/params/register_device_token_params.dart';

abstract class NotificationRepository {
  Future<ApiResult<void>> registerDeviceToken(RegisterDeviceTokenParams params);

  Future<ApiResult<void>> unregisterDeviceToken(String token);
}
