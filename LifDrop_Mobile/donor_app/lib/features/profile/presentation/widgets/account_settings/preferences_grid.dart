import 'package:donor_app/core/helpers/extensions.dart';
import 'package:donor_app/core/helpers/spacing.dart';
import 'package:donor_app/core/logic/language/language_cubit.dart';
import 'package:donor_app/features/profile/presentation/widgets/account_settings/preference_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_symbols_icons/symbols.dart';

class PreferencesGrid extends StatelessWidget {
  const PreferencesGrid({super.key, this.onLanguageTap, this.onThemeTap});

  final VoidCallback? onLanguageTap;
  final VoidCallback? onThemeTap;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: PreferenceCard(
            label: context.localizations.language_label,
            value:
                context.read<LanguageCubit>().state.locale.languageCode == 'ar'
                ? 'العربية'
                : 'English',
            icon: Symbols.language,
            onTap: onLanguageTap,
          ),
        ),
        horizontalSpace(12),
        Expanded(
          child: PreferenceCard(
            label: context.localizations.theme_label,
            value: context.isDarkMode
                ? context.localizations.theme_dark
                : context.localizations.theme_light,
            icon: context.isDarkMode ? Symbols.dark_mode : Symbols.light_mode,
            onTap: onThemeTap,
          ),
        ),
      ],
    );
  }
}
