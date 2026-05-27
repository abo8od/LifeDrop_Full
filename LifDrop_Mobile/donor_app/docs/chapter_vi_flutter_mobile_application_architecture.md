# Chapter VI — Flutter Mobile Application Architecture

## 1. Project Setup and Dependencies

The LifeDrop donor mobile application is a Flutter application with the app version `1.14.17+4`.

Targeted SDK versions:

- Flutter SDK installed: `3.41.7`
- Dart SDK installed: `3.11.5`
- Dart constraint in `pubspec.yaml`: `^3.11.1`
- SDK constraints in `pubspec.lock`: Dart `>=3.11.1 <4.0.0`, Flutter `>=3.38.4`
- Minimum Android API level: API `24`, inherited from Flutter Gradle `flutter.minSdkVersion`
- Minimum iOS version: `13.0`

Direct application dependencies with exact resolved versions:

| Package | Version |
|---|---:|
| app_settings | 7.0.0 |
| cached_network_image | 3.4.1 |
| cupertino_icons | 1.0.9 |
| curved_navigation_bar | 1.0.6 |
| dio | 5.9.2 |
| dropdown_button2 | 2.3.9 |
| equatable | 2.0.8 |
| firebase_core | 4.9.0 |
| firebase_crashlytics | 5.2.2 |
| firebase_messaging | 16.2.2 |
| flutter | SDK |
| flutter_bloc | 9.1.1 |
| flutter_local_notifications | 21.0.0 |
| flutter_localizations | SDK |
| flutter_native_splash | 2.4.7 |
| flutter_screenutil | 5.9.3 |
| flutter_secure_storage | 9.2.4 |
| flutter_svg | 2.3.0 |
| freezed | 3.2.5 |
| freezed_annotation | 3.1.0 |
| geocoding | 4.0.0 |
| geolocator | 14.0.2 |
| get_it | 8.3.0 |
| image_picker | 1.2.2 |
| intl | 0.20.2 |
| json_annotation | 4.12.0 |
| json_serializable | 6.14.0 |
| local_auth | 3.0.1 |
| material_symbols_icons | 4.2928.1 |
| package_info_plus | 9.0.1 |
| path_provider | 2.1.5 |
| pin_code_fields | 9.3.0 |
| pretty_dio_logger | 1.4.0 |
| retrofit | 4.9.2 |
| retrofit_generator | 10.2.6 |
| rxdart | 0.28.0 |
| shared_preferences | 2.5.5 |
| signalr_netcore | 1.4.4 |
| skeletonizer | 2.1.3 |
| url_launcher | 6.3.2 |
| uuid | 4.5.3 |

Development dependencies:

| Package | Version |
|---|---:|
| build_runner | 2.15.0 |
| flutter_lints | 6.0.0 |
| flutter_test | SDK |

## 2. Project Structure

The project is organized using a feature-first Clean Architecture structure. Shared infrastructure lives in `core`, while each main product area is isolated under `features`.

```text
lib/
  app.dart
  main_development.dart
  main_production.dart
  core/
    di/
    entities/
    enums/
    helpers/
    logic/
    mixins/
    models/
    networking/
    resources/
    routing/
    themes/
    widgets/
  features/
    all_requests/
      data/
      domain/
      presentation/
    auth/
      data/
      domain/
      presentation/
    donation_history/
      data/
      domain/
      presentation/
    donation_request/
      data/
      domain/
      presentation/
    home/
      data/
      domain/
      presentation/
    main_navigation/
    notifications/
      data/
      domain/
      presentation/
    onboarding/
    profile/
      data/
      domain/
      presentation/
    realtime/
      data/
      domain/
      presentation/
    requests/
      data/
      domain/
      presentation/
    splash/
      data/
      domain/
      presentation/
  l10n/
```

The `core` folder contains dependency injection, routing, themes, networking, reusable widgets, helper utilities, shared enums, shared entities, and shared models. Feature folders contain the data, domain, and presentation code for each functional area.

## 3. Architecture and State Management

The application follows Clean Architecture with a feature-first organization. Remote data sources perform API calls, repositories abstract the data layer, domain entities represent business-facing models, and presentation contains screens, widgets, Cubits, and states.

State management uses `flutter_bloc`, specifically Cubits. Examples include `LoginCubit`, `RegisterCubit`, `HomeCubit`, `AllRequestsCubit`, `DonationRequestCubit`, `ActiveDonationCubit`, `ProfileCubit`, `DeviceTokenCubit`, and `RealtimeCubit`.

States are typed and generally use either `Equatable` or Freezed-generated union states. UI widgets consume state through `BlocBuilder`, `BlocListener`, and `BlocProvider`, while business logic such as API calls, pagination, authentication, token registration, and realtime event handling lives outside widgets.

Dependency injection is handled with `get_it` in `core/di/injection_container.dart`.

## 4. User Roles and Screens

The mobile application targets donors specifically.

Routing uses Flutter's built-in `Navigator` through `MaterialApp.onGenerateRoute` and `MaterialPageRoute`. The project does not use `go_router`, `auto_route`, or Navigator 2.0 routing packages.

The main authenticated area uses a bottom navigation structure powered by `curved_navigation_bar`. The four main tabs are:

- Home
- Active Donation
- Donation History
- Profile

Application screens:

| Screen | Description |
|---|---|
| Splash Screen | Displays startup loading, requests location permission, and decides whether to show onboarding or login. |
| Onboarding View / Onboarding Screen | First-time donor onboarding carousel. |
| Login Screen | Authenticates donors and supports biometric login shortcut. |
| Register Screen | Handles donor account registration. |
| OTP Verification Screen | Verifies registration or password-reset OTP codes. |
| Forgot Password Screen | Starts the password reset flow by email. |
| Reset Password Screen | Submits a new password after OTP verification. |
| Main Navigation Screen | Hosts the four-tab donor application shell. |
| Home Screen | Shows donor dashboard data, greeting, summary, and request cards. |
| Active Requests Screen | Present in source, but not wired as a main route in `AppRouter`. |
| All Requests Screen | Displays a paginated and searchable donation request feed. |
| Request Details Screen | Shows details for a specific donation request and supports accepting the request. |
| Request Accepted Screen | Shows confirmation after a request has been accepted. |
| Active Donation Screen | Displays the current active donation, countdown/status, and available actions. |
| Cancel Donation Screen | Allows cancelling an accepted donation with a selected reason. |
| Donation History Screen | Shows paginated donor donation history. |
| Profile Screen | Shows donor profile, identity information, cooldown status, and account links. |
| Account Settings Screen | Shows account preferences, personal information, biometric settings, and logout. |
| Edit Profile Screen | Allows editing donor profile information. |
| Language Settings Screen | Allows switching the app language. |
| Theme Settings Screen | Allows switching the app theme. |

## 5. Authentication Integration

JWT access and refresh tokens are stored securely using `flutter_secure_storage 9.2.4` through the shared `SharedPrefHelper`.

Authentication flow:

- `LoginCubit` calls `AuthRepository.login`.
- `AuthRepositoryImpl` calls the auth remote data source.
- On successful login, the access token and refresh token are saved with `SharedPrefHelper.setSecuredString`.
- `DioFactory.setTokenIntoHeaderAfterLogin` updates the global Dio authorization header.

Token expiration and refresh:

- `AuthInterceptor` catches `401 Unauthorized` Dio errors.
- Public auth endpoints are excluded from refresh logic.
- The interceptor calls `AuthRepository.refreshToken` with the old access token and refresh token.
- If refresh succeeds, the new tokens are saved and the failed request is retried.
- If refresh fails, secure storage is cleared and the app navigates to the login screen.

Route protection:

- The app does not currently implement a formal route guard in `AppRouter`.
- Protected access is mainly handled through stored tokens, backend authentication, and logout-on-refresh-failure.
- The splash flow routes first-time users to onboarding and returning users to login; it does not currently auto-route authenticated users directly to the main navigation screen.

## 6. Backend API Integration

The application uses `Dio 5.9.2` as the HTTP client.

The API layer is centralized around:

- `DioFactory`
- `AuthInterceptor`
- `SafeApiCallMixin`
- `ApiErrorHandler`
- `ApiResult`
- Feature-specific remote data sources
- Feature-specific repositories

Base API URL:

```text
https://lifedrop-vh2h.onrender.com/api
```

Realtime base URL:

```text
https://lifedrop-vh2h.onrender.com
```

API calls are made inside remote data source classes only. Repositories convert or expose the results to domain and presentation layers.

Global error handling:

- Dio errors are mapped by `ApiErrorHandler`.
- API calls are wrapped with `SafeApiCallMixin`.
- Failures are returned as `ApiResult.failure`.
- API exceptions are logged to Firebase Crashlytics.

JWT handling:

- `DioFactory` configures the `Authorization: Bearer <token>` header.
- `AuthInterceptor` refreshes expired tokens and retries failed requests.
- `PrettyDioLogger` is registered for request and response logging.

## 7. Real-Time Communication: SignalR

SignalR package:

```text
signalr_netcore 1.4.4
```

The realtime feature is implemented with:

- `DonationsHubService`
- `RealtimeCubit`
- `RealtimeEvent` domain entities

Connection lifecycle:

- `MainNavigationScreen.initState` calls `RealtimeCubit.connect`.
- `RealtimeCubit` subscribes to `DonationsHubService.events`.
- `DonationsHubService` creates a `HubConnection` with `HubConnectionBuilder`.
- The JWT access token is supplied through `HttpConnectionOptions.accessTokenFactory`.
- Automatic reconnect is configured with retry delays of `0`, `2000`, `5000`, `10000`, and `30000` milliseconds.
- `MainNavigationScreen.dispose` calls `RealtimeCubit.disconnect`.

Subscribed SignalR events:

- `NewDonationRequest`
- `ActiveDonationUpdated`
- `Notification`
- `ProfileUpdated`
- `onreconnected`
- `onclose`

UI update behavior:

- SignalR callbacks convert payloads into typed `RealtimeEvent` objects.
- `RealtimeCubit` emits a `RealtimeState` containing the event.
- `MainNavigationScreen` listens to realtime state changes.
- Home, active donation, profile, and cooldown data are refreshed or updated depending on the event.
- User-visible messages are shown through snackbars.

## 8. Push Notifications: Firebase Cloud Messaging

FCM package:

```text
firebase_messaging 16.2.2
```

Local notification package:

```text
flutter_local_notifications 21.0.0
```

Notification handling is implemented in `NotificationService`.

Foreground notifications:

- `FirebaseMessaging.onMessage.listen` listens for messages while the app is open.
- Foreground messages are displayed using `flutter_local_notifications`.

Background notifications:

- `FirebaseMessaging.onBackgroundMessage` registers `_firebaseMessagingBackgroundHandler`.
- The background handler initializes Firebase.

Terminated notifications:

- `FirebaseMessaging.instance.getInitialMessage` is checked during notification service initialization.
- If an initial message exists, the app attempts to handle the notification tap.

Deep linking:

- Notification payloads use a `requestId` field.
- Taps navigate to `Routes.requestDetails` with the `requestId` argument.
- Local notifications also store the `requestId` as the notification payload.

Device token registration:

- `NotificationService.getAuthorizedDeviceToken` requests notification permission and retrieves the FCM token.
- `DeviceTokenCubit.registerDeviceToken` sends the token to the backend.
- Registration is triggered when the main navigation screen is created.
- Token refresh is handled with `FirebaseMessaging.onTokenRefresh`.
- Refreshed tokens are sent to the backend only when access and refresh tokens are available.

## 9. Local Data Persistence

The app uses two local persistence mechanisms:

- `flutter_secure_storage` for sensitive tokens.
- `shared_preferences` for non-sensitive preferences.

Securely stored data:

- `accessToken`
- `refreshToken`

Shared preferences data:

- `hasSeenOnboarding`
- `isLoggedIn`
- `biometricEnabled`
- `biometricPromptShown`
- `appLanguage`
- `themeMode`

The app does not currently implement offline-first behavior. Backend data is fetched from APIs, while local storage is primarily used for authentication state and user preferences.

## 10. Key UI Components and Design

Important reusable UI components include:

- `DonationRequestCard`
- `BloodTypeBadge`
- `UrgencyIndicator`
- `DonationSummary`
- `CriticalRequestBanner`
- `DonationProgressCard`
- `CooldownCard`
- `DonationHistoryCard`
- `HistoryStatusChip`
- `AppElevatedButton`
- `AppTextButton`
- `AppDropDownButtonField`
- `BloodTypeSelector`
- `AppHeader`
- `AppLinearProgress`
- `CustomNavigationBar`

Design and theme:

- The project uses custom light and dark themes.
- A custom `ThemeExtension` named `AppColors` defines the color system.
- Responsive sizing is handled with `flutter_screenutil`.
- English and Arabic localization is supported through generated Flutter localization files.

Main color palette:

| Token | Light | Dark |
|---|---:|---:|
| Primary | `#B7102A` | `#B7102A` |
| Secondary | `#2B6485` | `#98CDF2` |
| Background | `#F7F9FE` | `#0B0E11` |
| Navigation Bar | `#FFFFFF` | `#0F172A` |
| Surface | `#DFE3E8` | `#33353A` |
| Text Primary | `#181C20` | `#E1E2E8` |
| Icon Active | `#E63946` | `#FF4D4D` |

No custom font family is declared in `pubspec.yaml`, so the app uses Flutter's default Material/platform font.

## 11. Performance Optimizations

Implemented optimizations:

- Pagination for all donation requests.
- Pagination for donation history.
- Page size of `10` for paginated lists.
- Lazy loading of main tab data when tabs are first opened.
- Cached network images through `cached_network_image`.
- Skeleton loading states through `skeletonizer`.
- Responsive UI scaling with `flutter_screenutil`.

Known build size:

- Existing development debug APK: approximately `135.71 MB`.
- No release APK or IPA size was available in the current build outputs.

## 12. Security

Sensitive data storage:

- JWT access and refresh tokens are stored using `flutter_secure_storage`.
- Logout clears secure storage.

Authentication security:

- Expired tokens are refreshed through a centralized Dio queued interceptor.
- Failed refresh clears tokens and returns the user to login.
- Biometric login support is implemented using `local_auth`.

Security gaps or items to address before production:

- No certificate pinning was found.
- No release obfuscation configuration was found.
- Android release signing currently uses the debug signing config.
- The Android application ID is still `com.example.donor_app`.
- `DioFactory` currently sets `badCertificateCallback` to always return `true`, which disables TLS certificate validation and should not be used in production.
- `SharedPrefHelper.setSecuredString` logs secure values in debug output, which should be removed.

## 13. Testing

Testing package:

```text
flutter_test
```

Current testing status:

- One placeholder widget test exists in `test/widget_test.dart`.
- The test is still a default counter-style smoke test and does not test the real app.
- No meaningful unit, widget, or integration test coverage was found.
- No coverage report was present.

## 14. Build and Release

The Android project defines two product flavors:

- `development`
- `production`

Main entry files:

- `lib/main_development.dart`
- `lib/main_production.dart`

Android release APK commands:

```bash
flutter build apk --release --flavor development -t lib/main_development.dart
flutter build apk --release --flavor production -t lib/main_production.dart
```

Android App Bundle command:

```bash
flutter build appbundle --release --flavor production -t lib/main_production.dart
```

iOS release command:

```bash
flutter build ipa --release --flavor production -t lib/main_production.dart
```

Release status:

- Android flavor configuration is present.
- Android release signing currently uses debug signing.
- No Play Store or App Store submission evidence was found in the repository.
- The current setup appears more suitable for direct APK/internal distribution until release signing and store deployment are finalized.

## 15. Known Limitations and Technical Debt

Known limitations and technical debt:

- No formal route guard is implemented.
- Splash does not currently route already-authenticated users directly to the main app.
- Notification tap handling appears incomplete when `navigatorKey.currentState` is already available.
- TLS certificate validation is disabled in Dio and should be fixed before production.
- Release signing still uses the debug signing configuration.
- Android application ID is still `com.example.donor_app`.
- Tests are placeholder-level only.
- No offline-first mode is implemented.
- No release APK or IPA size was available.
- No certificate pinning or release obfuscation configuration was found.
