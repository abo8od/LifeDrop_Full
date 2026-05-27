import 'dart:async';
import 'dart:ui';

import 'package:donor_app/app.dart';
import 'package:donor_app/core/di/injection_container.dart';
import 'package:donor_app/core/helpers/constants.dart';
import 'package:donor_app/core/helpers/shared_pref_helper.dart';
import 'package:donor_app/core/routing/app_router.dart';
import 'package:donor_app/features/notifications/data/services/notification_service.dart';
import 'package:donor_app/features/notifications/presentation/logic/device_token_cubit.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
}

void main(List<String> args) {
  runZonedGuarded(
    () async {
      WidgetsFlutterBinding.ensureInitialized();
      await ScreenUtil.ensureScreenSize();
      await Firebase.initializeApp();
      FirebaseMessaging.onBackgroundMessage(
        _firebaseMessagingBackgroundHandler,
      );
      await initDependencies();
      await getIt<NotificationService>().initializeHandlers(
        onTokenRefresh: (token) async {
          final accessToken = await SharedPrefHelper.getSecuredString(
            SharedPrefKeys.accessToken,
          );
          final refreshToken = await SharedPrefHelper.getSecuredString(
            SharedPrefKeys.refreshToken,
          );
          if (accessToken.isNotEmpty && refreshToken.isNotEmpty) {
            await getIt<DeviceTokenCubit>().registerDeviceToken(
              refreshedToken: token,
            );
          }
        },
      );
      FlutterError.onError = (details) {
        FirebaseCrashlytics.instance.recordFlutterError(details);
      };

      PlatformDispatcher.instance.onError = (error, stack) {
        FirebaseCrashlytics.instance.recordError(error, stack);
        return true;
      };
      runApp(App(appRouter: AppRouter()));
    },
    (error, stack) {
      FirebaseCrashlytics.instance.recordError(error, stack);
    },
  );
}
