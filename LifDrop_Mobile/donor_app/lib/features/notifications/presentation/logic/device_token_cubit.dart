import 'package:donor_app/core/helpers/constants.dart';
import 'package:donor_app/core/helpers/shared_pref_helper.dart';
import 'package:donor_app/features/notifications/domain/params/register_device_token_params.dart';
import 'package:donor_app/features/notifications/domain/repositories/notification_repository.dart';
import 'package:donor_app/features/notifications/data/services/notification_service.dart';
import 'package:donor_app/features/notifications/presentation/logic/device_token_state.dart';
import 'package:donor_app/core/networking/api_result.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DeviceTokenCubit extends Cubit<DeviceTokenState> {
  final NotificationRepository _notificationRepository;
  final NotificationService _notificationService;

  DeviceTokenCubit(this._notificationRepository, this._notificationService)
    : super(const DeviceTokenState.initial());

  Future<void> registerDeviceToken({String? refreshedToken}) async {
    final isLoggedIn = await SharedPrefHelper.getBool(
      SharedPrefKeys.isLoggedIn,
    );
    if (!isLoggedIn) return;

    final token =
        refreshedToken ?? await _notificationService.getAuthorizedDeviceToken();
    if (token == null || token.isEmpty) return;

    emit(const DeviceTokenState.loading());

    final result = await _notificationRepository.registerDeviceToken(
      RegisterDeviceTokenParams(
        token: token,
        platform: _notificationService.platformValue,
      ),
    );

    result.when(
      success: (_) => emit(const DeviceTokenState.registered()),
      failure: (error) => emit(DeviceTokenState.error(error)),
    );
  }

  Future<void> unregisterDeviceToken() async {
    final token = await _notificationService.getDeviceToken();
    if (token == null || token.isEmpty) return;

    emit(const DeviceTokenState.loading());

    final result = await _notificationRepository.unregisterDeviceToken(token);

    result.when(
      success: (_) => emit(const DeviceTokenState.unregistered()),
      failure: (error) => emit(DeviceTokenState.error(error)),
    );
  }
}
