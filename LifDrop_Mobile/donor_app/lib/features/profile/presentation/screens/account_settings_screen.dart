import 'package:donor_app/core/helpers/extensions.dart';
import 'package:donor_app/core/helpers/spacing.dart';
import 'package:donor_app/features/profile/domain/entities/user_entity.dart';
import 'package:donor_app/features/profile/presentation/widgets/account_settings/header_sction.dart';
import 'package:donor_app/features/profile/presentation/widgets/account_settings/logout_button.dart';
import 'package:donor_app/features/profile/presentation/widgets/account_settings/personal_info_section.dart';
import 'package:donor_app/features/profile/presentation/widgets/account_settings/preferences_section.dart';
import 'package:donor_app/features/profile/presentation/widgets/account_settings/security_section.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AccountSettingsScreen extends StatelessWidget {
  const AccountSettingsScreen({super.key, required this.user});
  final UserEntity user;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.colors.background,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: Column(
            children: [
              const HeaderSection(),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      verticalSpace(10),
                      PersonalInfoSection(user: user),
                      verticalSpace(38),
                      const SecuritySection(),
                      verticalSpace(38),
                      const PreferencesSection(),
                      verticalSpace(38),
                      const LogoutButton(),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
