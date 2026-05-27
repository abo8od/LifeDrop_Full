import 'package:donor_app/core/helpers/extensions.dart';
import 'package:donor_app/core/widgets/app_header.dart';
import 'package:flutter/material.dart';

class LanguageSettingsHeader extends StatelessWidget {
  const LanguageSettingsHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return AppHeader(
      icon: GestureDetector(
        onTap: () => context.pop(),
        child: Icon(Icons.arrow_back, color: context.colors.textPrimary),
      ),
      title: context.localizations.language_settings,
      style: context.textStyles.font20TextPrimaryBold.copyWith(
        letterSpacing: -0.5,
      ),
    );
  }
}
