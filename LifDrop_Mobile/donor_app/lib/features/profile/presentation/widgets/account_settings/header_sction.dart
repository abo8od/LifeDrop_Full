import 'package:donor_app/core/helpers/extensions.dart';
import 'package:donor_app/core/widgets/app_header.dart';
import 'package:flutter/material.dart';

class HeaderSection extends StatelessWidget {
  const HeaderSection({super.key});

  @override
  Widget build(BuildContext context) {
    return AppHeader(
      icon: GestureDetector(
        onTap: () => context.pop(),
        child: Icon(Icons.arrow_back, color: context.colors.textPrimary),
      ),
      title: context.localizations.account_settings_title,
      style: context.textStyles.font20TextPrimaryBold.copyWith(
        letterSpacing: -0.5,
      ),
    );
  }
}
