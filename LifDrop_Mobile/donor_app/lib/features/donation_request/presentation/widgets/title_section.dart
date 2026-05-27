import 'package:donor_app/core/helpers/extensions.dart';
import 'package:donor_app/core/helpers/spacing.dart';
import 'package:flutter/material.dart';

class TitleSection extends StatelessWidget {
  const TitleSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          context.localizations.donation_progress,
          style: context.textStyles.font20TextPrimaryBold,
        ),
        horizontalSpace(53),
        Expanded(
          child: Text(
            context.localizations.donors_confirmed_progress(2, 5),
            style: context.textStyles.font16PrimaryBold,
          ),
        ),
      ],
    );
  }
}
