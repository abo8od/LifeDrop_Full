import 'package:donor_app/core/helpers/extensions.dart';
import 'package:donor_app/core/helpers/spacing.dart';
import 'package:donor_app/core/routing/routes.dart';
import 'package:donor_app/features/profile/presentation/widgets/account_settings/preferences_grid.dart';
import 'package:donor_app/features/profile/presentation/widgets/section_header.dart';
import 'package:flutter/material.dart';

class PreferencesSection extends StatelessWidget {
  const PreferencesSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionHeader(title: context.localizations.preferences_label),
        verticalSpace(10),
        PreferencesGrid(
          onLanguageTap: () {
            context.pushNamed(Routes.languageSettings);
          },
          onThemeTap: () {
            context.pushNamed(Routes.themeSettings);
          },
        ),
      ],
    );
  }
}
