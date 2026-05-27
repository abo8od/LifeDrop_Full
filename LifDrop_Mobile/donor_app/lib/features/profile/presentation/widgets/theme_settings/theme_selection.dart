import 'package:donor_app/core/helpers/extensions.dart';
import 'package:donor_app/core/helpers/spacing.dart';
import 'package:donor_app/core/logic/theme/theme_cubit.dart';
import 'package:donor_app/core/logic/theme/theme_state.dart';
import 'package:donor_app/core/resources/image_paths.dart';
import 'package:donor_app/features/profile/presentation/widgets/theme_settings/theme_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ThemeSelection extends StatelessWidget {
  const ThemeSelection({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeState>(
      builder: (context, state) {
        final currentMode = state.themeMode.index;
        return SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 10.h),
            child: Column(
              children: [
                ThemeCard(
                  title: context.localizations.theme_system_default,
                  description: context.localizations.theme_system_description,
                  image: ImagePaths.systemTheme,
                  icon: Icon(
                    Icons.settings_brightness,
                    color: context.colors.secondary,
                  ),
                  isSelected: currentMode == 0,
                  iconBackgroundColor: context.colors.tertiary,
                  onTap: () =>
                      context.read<ThemeCubit>().setTheme(ThemeMode.system),
                ),
                verticalSpace(24),
                ThemeCard(
                  title: context.localizations.theme_light_mode,
                  description:
                      context.localizations.theme_light_description,
                  image: ImagePaths.lightTheme,
                  icon: Icon(
                    Icons.wb_sunny_outlined,
                    color: context.colors.secondary,
                  ),
                  isSelected: currentMode == 1,
                  iconBackgroundColor: context.colors.tertiary,
                  onTap: () =>
                      context.read<ThemeCubit>().setTheme(ThemeMode.light),
                ),
                verticalSpace(24),
                ThemeCard(
                  title: context.localizations.theme_dark_mode,
                  description: context.localizations.theme_dark_description,
                  image: ImagePaths.darkTheme,
                  icon: Icon(
                    Icons.dark_mode_outlined,
                    color: context.colors.textSecondary,
                  ),
                  isSelected: currentMode == 2,
                  iconBackgroundColor: context.colors.textSecondary.withAlpha(
                    25,
                  ),
                  onTap: () =>
                      context.read<ThemeCubit>().setTheme(ThemeMode.dark),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
