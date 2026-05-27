import 'package:dio/dio.dart';
import 'package:donor_app/core/helpers/biometric_helper.dart';
import 'package:donor_app/core/logic/biometric/biometric_cubit.dart';
import 'package:donor_app/core/logic/language/language_cubit.dart';
import 'package:donor_app/core/logic/theme/theme_cubit.dart';
import 'package:donor_app/core/networking/dio_factory.dart';
import 'package:donor_app/features/all_requests/data/datasources/all_requests_remote_datasource_impl.dart';
import 'package:donor_app/features/all_requests/data/repositories/all_requests_repository_impl.dart';
import 'package:donor_app/features/all_requests/domain/repositories/all_requests_repository.dart';
import 'package:donor_app/features/all_requests/presentation/logic/all_requests_cubit.dart';
import 'package:donor_app/features/auth/data/datasources/auth_remote_datasource_impl.dart';
import 'package:donor_app/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:donor_app/features/auth/domain/repositories/auth_repository.dart';
import 'package:donor_app/features/auth/presentation/logic/forgot_password/forgot_password_cubit.dart';
import 'package:donor_app/features/auth/presentation/logic/login/login_cubit.dart';
import 'package:donor_app/features/auth/presentation/logic/otp/otp_cubit.dart';
import 'package:donor_app/features/auth/presentation/logic/register/register_cubit.dart';
import 'package:donor_app/features/auth/presentation/logic/reset_password/reset_password_cubit.dart';
import 'package:donor_app/features/donation_request/data/datasources/donation_request_remote_datasource_impl.dart';
import 'package:donor_app/features/donation_request/data/repositories/donation_request_repository_impl.dart';
import 'package:donor_app/features/donation_request/domain/repositories/donation_request_repository.dart';
import 'package:donor_app/features/donation_request/presentation/logic/donation_request_cubit.dart';
import 'package:donor_app/features/donation_history/data/datasources/donation_history_remote_datasource_impl.dart';
import 'package:donor_app/features/donation_history/data/repositories/donation_history_repository_impl.dart';
import 'package:donor_app/features/donation_history/domain/repositories/donation_history_repository.dart';
import 'package:donor_app/features/donation_history/presentation/logic/donation_history_cubit.dart';
import 'package:donor_app/features/home/data/datasource/home_remote_datasource_impl.dart';
import 'package:donor_app/features/home/data/repositories/home_repository_impl.dart';
import 'package:donor_app/features/home/domain/repositories/home_repository.dart';
import 'package:donor_app/features/home/presentation/logic/home_cubit.dart';
import 'package:donor_app/features/notifications/data/datasources/notification_remote_datasource_impl.dart';
import 'package:donor_app/features/notifications/data/repositories/notification_repository_impl.dart';
import 'package:donor_app/features/notifications/data/services/notification_service.dart';
import 'package:donor_app/features/notifications/domain/repositories/notification_repository.dart';
import 'package:donor_app/features/notifications/presentation/logic/device_token_cubit.dart';
import 'package:donor_app/features/profile/data/datasources/profile_remote_datasource_impl.dart';
import 'package:donor_app/features/profile/data/repositories/profile_repository_impl.dart';
import 'package:donor_app/features/profile/domain/repositories/profile_repository.dart';
import 'package:donor_app/features/profile/presentation/logic/cooldown/cooldown_cubit.dart';
import 'package:donor_app/features/profile/presentation/logic/edit_profile/edit_profile_cubit.dart';
import 'package:donor_app/features/profile/presentation/logic/profile/profile_cubit.dart';
import 'package:donor_app/features/realtime/data/services/donations_hub_service.dart';
import 'package:donor_app/features/realtime/presentation/logic/realtime_cubit.dart';
import 'package:donor_app/features/requests/data/datasource/requests_remote_datasource_impl.dart';
import 'package:donor_app/features/requests/data/repository/requests_repository_impl.dart';
import 'package:donor_app/features/requests/domain/repository/requests_repository.dart';
import 'package:donor_app/features/requests/presentation/logic/active_donation/active_donation_cubit.dart';
import 'package:donor_app/features/requests/presentation/logic/cancel_donation/cancel_donation_cubit.dart';
import 'package:donor_app/features/requests/presentation/logic/cancellation_reasons/cancellation_reasons_cubit.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;
final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

Future<void> initDependencies() async {
  final dio = await DioFactory.getDio();

  getIt.registerLazySingleton<Dio>(() => dio);

  getIt.registerLazySingleton<BiometricHelper>(() => BiometricHelper());

  // --------------- Settings ---------------

  getIt.registerLazySingleton<LanguageCubit>(() => LanguageCubit());
  getIt.registerLazySingleton<ThemeCubit>(() => ThemeCubit());
  getIt.registerLazySingleton<BiometricCubit>(() => BiometricCubit());

  // --------------- Auth ---------------

  getIt.registerLazySingleton<AuthRemoteDataSourceImpl>(
    () => AuthRemoteDataSourceImpl(getIt<Dio>()),
  );

  getIt.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(getIt<AuthRemoteDataSourceImpl>()),
  );

  getIt.registerFactory<LoginCubit>(
    () => LoginCubit(getIt<AuthRepository>(), getIt<DeviceTokenCubit>()),
  );

  getIt.registerFactory<RegisterCubit>(
    () => RegisterCubit(getIt<AuthRepository>()),
  );

  getIt.registerFactory<OtpCubit>(() => OtpCubit(getIt<AuthRepository>()));

  getIt.registerFactory<ForgotPasswordCubit>(
    () => ForgotPasswordCubit(getIt<AuthRepository>()),
  );

  getIt.registerFactory<ResetPasswordCubit>(
    () => ResetPasswordCubit(getIt<AuthRepository>()),
  );

  // --------------- Home ---------------
  getIt.registerLazySingleton<HomeRemoteDatasourceImpl>(
    () => HomeRemoteDatasourceImpl(getIt<Dio>()),
  );

  getIt.registerLazySingleton<HomeRepository>(
    () => HomeRepositoryImpl(getIt<HomeRemoteDatasourceImpl>()),
  );

  getIt.registerFactory<HomeCubit>(
    () => HomeCubit(
      biometricHelper: getIt<BiometricHelper>(),
      homeRepository: getIt<HomeRepository>(),
    ),
  );

  // --------------- All Requests ---------------

  getIt.registerLazySingleton<AllRequestsRemoteDatasource>(
    () => AllRequestsRemoteDatasourceImpl(getIt<Dio>()),
  );

  getIt.registerLazySingleton<AllRequestsRepository>(
    () => AllRequestsRepositoryImpl(getIt<AllRequestsRemoteDatasource>()),
  );

  getIt.registerFactory<AllRequestsCubit>(
    () => AllRequestsCubit(getIt<AllRequestsRepository>()),
  );

  // --------------- Notifications ---------------

  getIt.registerLazySingleton<NotificationRemoteDatasource>(
    () => NotificationRemoteDatasourceImpl(getIt<Dio>()),
  );

  getIt.registerLazySingleton<NotificationRepository>(
    () => NotificationRepositoryImpl(getIt<NotificationRemoteDatasource>()),
  );

  getIt.registerLazySingleton<NotificationService>(() => NotificationService());

  getIt.registerFactory<DeviceTokenCubit>(
    () => DeviceTokenCubit(
      getIt<NotificationRepository>(),
      getIt<NotificationService>(),
    ),
  );

  // --------------- Realtime ---------------

  getIt.registerLazySingleton<DonationsHubService>(() => DonationsHubService());

  getIt.registerFactory<RealtimeCubit>(
    () => RealtimeCubit(getIt<DonationsHubService>()),
  );

  // --------------- Donation Request ---------------

  getIt.registerLazySingleton<DonationRequestRemoteDatasource>(
    () => DonationRequestRemoteDatasourceImpl(getIt<Dio>()),
  );

  getIt.registerLazySingleton<DonationRequestRepository>(
    () =>
        DonationRequestRepositoryImpl(getIt<DonationRequestRemoteDatasource>()),
  );

  getIt.registerFactory<DonationRequestCubit>(
    () => DonationRequestCubit(getIt<DonationRequestRepository>()),
  );

  // --------------- Donation History ---------------

  getIt.registerLazySingleton<DonationHistoryRemoteDatasource>(
    () => DonationHistoryRemoteDatasourceImpl(getIt<Dio>()),
  );

  getIt.registerLazySingleton<DonationHistoryRepository>(
    () =>
        DonationHistoryRepositoryImpl(getIt<DonationHistoryRemoteDatasource>()),
  );

  getIt.registerFactory<DonationHistoryCubit>(
    () => DonationHistoryCubit(getIt<DonationHistoryRepository>()),
  );

  // --------------- Requests ---------------

  getIt.registerLazySingleton<RequestsRemoteDatasourceImpl>(
    () => RequestsRemoteDatasourceImpl(getIt<Dio>()),
  );

  getIt.registerLazySingleton<RequestsRepository>(
    () => RequestsRepositoryImpl(getIt<RequestsRemoteDatasourceImpl>()),
  );

  getIt.registerFactory<ActiveDonationCubit>(
    () => ActiveDonationCubit(getIt<RequestsRepository>()),
  );
  getIt.registerFactory<CancelDonationCubit>(
    () => CancelDonationCubit(getIt<RequestsRepository>()),
  );
  getIt.registerFactory<CancellationReasonsCubit>(
    () => CancellationReasonsCubit(getIt<RequestsRepository>()),
  );

  // --------------- Profile ---------------

  getIt.registerLazySingleton<ProfileRemoteDatasource>(
    () => ProfileRemoteDatasourceImpl(getIt<Dio>()),
  );

  getIt.registerLazySingleton<ProfileRepository>(
    () => ProfileRepositoryImpl(getIt<ProfileRemoteDatasource>()),
  );

  getIt.registerFactory<ProfileCubit>(
    () => ProfileCubit(getIt<ProfileRepository>()),
  );
  getIt.registerFactory<CooldownCubit>(
    () => CooldownCubit(getIt<ProfileRepository>()),
  );
  getIt.registerFactory<EditProfileCubit>(
    () => EditProfileCubit(getIt<ProfileRepository>()),
  );
}
