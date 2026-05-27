import 'package:donor_app/features/notifications/domain/params/register_device_token_params.dart';

class DeviceTokenRequestModel {
  final String token;
  final int? platform;

  const DeviceTokenRequestModel({required this.token, this.platform});

  factory DeviceTokenRequestModel.fromParams(RegisterDeviceTokenParams params) {
    return DeviceTokenRequestModel(
      token: params.token,
      platform: params.platform,
    );
  }

  Map<String, dynamic> toJson() {
    return {'token': token, if (platform != null) 'platform': platform};
  }
}
