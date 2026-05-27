import 'package:donor_app/features/profile/presentation/widgets/theme_settings/theme_selection.dart';
import 'package:donor_app/features/profile/presentation/widgets/theme_settings/theme_settings_header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ThemeSettingsScreen extends StatelessWidget {
  const ThemeSettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: const Column(
            children: [
              ThemeSettingsHeader(),
              Expanded(child: ThemeSelection()),
            ],
          ),
        ),
      ),
    );
  }
}
