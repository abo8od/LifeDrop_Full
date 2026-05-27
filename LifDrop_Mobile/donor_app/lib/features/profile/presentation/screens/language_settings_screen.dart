import 'package:donor_app/core/helpers/extensions.dart';
import 'package:donor_app/core/helpers/spacing.dart';
import 'package:donor_app/core/logic/language/language_cubit.dart';
import 'package:donor_app/core/logic/language/language_state.dart';
import 'package:donor_app/features/profile/presentation/widgets/language_settings/current_language_card.dart';
import 'package:donor_app/features/profile/presentation/widgets/language_settings/language_options_list.dart';
import 'package:donor_app/features/profile/presentation/widgets/language_settings/language_settings_header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LanguageSettingsScreen extends StatelessWidget {
  const LanguageSettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.colors.background,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: Column(
            children: [
              const LanguageSettingsHeader(),
              Expanded(
                child: SingleChildScrollView(
                  child: BlocBuilder<LanguageCubit, LanguageState>(
                    builder: (context, state) {
                      final isArabic = state.locale.languageCode == 'ar';

                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          verticalSpace(10),
                          CurrentLanguageCard(
                            languageName: isArabic ? 'العربية' : 'English',
                            //'sa' and 'us' is flag icon
                            flag: isArabic ? '🇸🇦' : '🇺🇸',
                          ),
                          verticalSpace(38),
                          const LanguageOptionsList(),
                          verticalSpace(32),
                        ],
                      );
                    },
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
