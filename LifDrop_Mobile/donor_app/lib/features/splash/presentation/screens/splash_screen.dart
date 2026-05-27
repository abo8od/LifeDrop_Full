import 'package:donor_app/core/helpers/constants.dart';
import 'package:donor_app/core/helpers/extensions.dart';
import 'package:donor_app/core/helpers/internet_connection_service.dart';
import 'package:donor_app/core/helpers/location_helper.dart';
import 'package:donor_app/core/helpers/shared_pref_helper.dart';
import 'package:donor_app/core/helpers/spacing.dart';
import 'package:donor_app/core/routing/routes.dart';
import 'package:donor_app/core/widgets/app_linear_progress.dart';
import 'package:donor_app/features/splash/presentation/widgets/loading_text.dart';
import 'package:donor_app/features/splash/presentation/widgets/splash_logo_circle.dart';
import 'package:donor_app/features/splash/presentation/widgets/tagline_text.dart';
import 'package:donor_app/features/splash/presentation/widgets/version_footer_with_motto_text.dart';
import 'package:donor_app/features/splash/presentation/widgets/wordmark_text.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final InternetConnectionService _internetConnectionService =
      const InternetConnectionService();
  double value = 0.0;

  Future<void> _prepareStartup() async {
    requestLocationPermission();

    final hasConnection = await _internetConnectionService.hasConnection();

    if (!mounted) return;

    if (!hasConnection) {
      await _internetConnectionService.waitForConnection();
    }

    if (!mounted) return;

    _startLoading();
  }

  void _startLoading() async {
    for (int i = 1; i <= 100; i++) {
      await Future.delayed(const Duration(milliseconds: 20));
      if (!mounted) return;

      setState(() {
        value = i / 100;
      });
    }

    final hasSeenOnboarding = await SharedPrefHelper.getBool(
      SharedPrefKeys.hasSeenOnboarding,
    );

    if (!mounted) return;

    if (!hasSeenOnboarding) {
      context.pushReplacementNamed(Routes.onboarding);
    } else {
      context.pushReplacementNamed(Routes.login);
    }
  }

  Future<void> requestLocationPermission() async {
    await LocationHelper.requestLocationPermission();
  }

  @override
  void initState() {
    super.initState();
    _prepareStartup();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: .min,
          children: [
            verticalSpace(220),
            const SplashLogoCircle(),
            verticalSpace(48),
            const WordmarkText(),
            verticalSpace(12),
            const TaglineText(),
            verticalSpace(197),
            AppLinearProgress(value: value),
            verticalSpace(12),
            const LoadingText(),
            const Spacer(),
            const VersionFooterWithMottoText(),
          ],
        ),
      ),
    );
  }
}
