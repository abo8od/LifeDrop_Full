import 'package:donor_app/core/helpers/extensions.dart';
import 'package:flutter/material.dart';

class WordmarkText extends StatelessWidget {
  const WordmarkText({super.key});

  @override
  Widget build(BuildContext context) {
    final bool isArabic = context.isArabic;
    final firstStyle = isArabic
        ? context.textStyles.font48PrimaryExtraBold.copyWith(
            letterSpacing: 2,
            wordSpacing: -10,
          )
        : context.textStyles.font48TextPrimaryExtraBold.copyWith(
            letterSpacing: 2,
            wordSpacing: -10,
          );
    final secondStyle = isArabic
        ? context.textStyles.font48TextPrimaryExtraBold.copyWith(
            letterSpacing: 2,
            wordSpacing: -10,
          )
        : context.textStyles.font48PrimaryExtraBold.copyWith(
            letterSpacing: 1.2,
          );
    return RichText(
      textDirection: Directionality.of(context),
      text: TextSpan(
        text: context.localizations.app_first_name,
        style: firstStyle,
        children: [
          TextSpan(
            text: context.localizations.app_last_name,
            style: secondStyle,
          ),
        ],
      ),
    );
  }
}
