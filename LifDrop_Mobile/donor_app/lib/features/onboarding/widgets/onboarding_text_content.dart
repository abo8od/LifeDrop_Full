import 'package:donor_app/core/helpers/extensions.dart';
import 'package:donor_app/core/helpers/spacing.dart';
import 'package:flutter/material.dart';

class OnboardingTextContent extends StatelessWidget {
  const OnboardingTextContent({
    super.key,
    required this.title,
    required this.subtitle,
    required this.index,
  });

  final String title;
  final String subtitle;
  final int index;

  @override
  Widget build(BuildContext context) {
    final bool isArabic = context.isArabic;
    final firstStyle = isArabic
        ? context.textStyles.font36PrimaryExtraBold.copyWith(letterSpacing: 2)
        : context.textStyles.font36TextPrimaryExtraBold.copyWith(
            letterSpacing: 2,
          );
    final secondStyle = isArabic
        ? context.textStyles.font36TextPrimaryExtraBold.copyWith(
            letterSpacing: 2,
          )
        : context.textStyles.font36PrimaryExtraBold.copyWith(
            letterSpacing: 1.2,
          );
    return Column(
      children: [
        if (index == 2)
          RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
              text: context.localizations.onboarding_title_3_part_1,
              style: firstStyle,
              children: [
                TextSpan(
                  text: context.localizations.onboarding_title_3_part_2,
                  style: secondStyle,
                ),
              ],
            ),
          ),
        if (index != 2)
          Text(
            title,
            style: context.textStyles.font36TextPrimaryExtraBold.copyWith(
              letterSpacing: -0.9,
            ),
            textAlign: TextAlign.center,
          ),
        verticalSpace(16),
        Text(
          subtitle,
          style: context.textStyles.font16SecondaryMedium.copyWith(
            letterSpacing: 0,
          ),
          textAlign: TextAlign.center,
          maxLines: null,
        ),
      ],
    );
  }
}
