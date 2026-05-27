import 'package:donor_app/core/helpers/extensions.dart';
import 'package:donor_app/core/helpers/spacing.dart';
import 'package:flutter/material.dart';

class TextCancelSection extends StatelessWidget {
  const TextCancelSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: .start,
      children: [
        RichText(
          text: TextSpan(
            text: context.localizations.review_heading,
            style: context.textStyles.font36TextPrimaryExtraBold,
            children: [
              TextSpan(
                text: context.localizations.cancellation_heading,
                style: context.textStyles.font36PrimaryExtraBold,
              ),
            ],
          ),
        ),
        verticalSpace(12),
        Text(
          context.localizations.cancellation_description,
          style: context.textStyles.font16SecondaryMedium,
        ),
      ],
    );
  }
}
