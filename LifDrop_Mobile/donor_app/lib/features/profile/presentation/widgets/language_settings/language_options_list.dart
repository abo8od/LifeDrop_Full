import 'package:donor_app/core/helpers/extensions.dart';
import 'package:donor_app/core/helpers/spacing.dart';
import 'package:donor_app/core/logic/language/language_cubit.dart';
import 'package:donor_app/core/logic/language/language_state.dart';
import 'package:donor_app/features/profile/presentation/widgets/language_settings/language_option_tile.dart';
import 'package:donor_app/features/profile/presentation/widgets/section_header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LanguageOptionsList extends StatelessWidget {
  const LanguageOptionsList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LanguageCubit, LanguageState>(
      builder: (context, state) {
        final currentCode = state.locale.languageCode;

        return Column(
          crossAxisAlignment: .start,
          children: [
            SectionHeader(
              title: context.localizations.available_languages_label,
            ),
            verticalSpace(10),
            Container(
              decoration: BoxDecoration(
                color: context.colors.neutral,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  LanguageOptionTile(
                    flag: '🇺🇸',
                    nativeName: 'English',
                    localizedName: context.localizations.language_english,
                    isSelected: currentCode == 'en',
                    onTap: () =>
                        context.read<LanguageCubit>().changeLanguage('en'),
                  ),
                  LanguageOptionTile(
                    flag: '🇸🇦',
                    nativeName: 'العربية',
                    localizedName: context.localizations.language_arabic,
                    isSelected: currentCode == 'ar',
                    onTap: () =>
                        context.read<LanguageCubit>().changeLanguage('ar'),
                    showDivider: true,
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
