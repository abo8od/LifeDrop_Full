import 'package:donor_app/core/helpers/extensions.dart';
import 'package:donor_app/core/helpers/spacing.dart';
import 'package:flutter/material.dart';

class SuccessTextSection extends StatelessWidget {
  const SuccessTextSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          context.localizations.you_are_a_lifesaver,
          style: context.textStyles.font36TextPrimaryExtraBold.copyWith(
            letterSpacing: -0.9,
          ),
        ),
        verticalSpace(12),
        Text(
          context.localizations.request_accepted_hospital_waiting,
          style: context.textStyles.font16SecondaryMedium.copyWith(
            letterSpacing: 0,
          ),
        ),
      ],
    );
  }
}
