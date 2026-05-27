import 'package:donor_app/core/helpers/extensions.dart';
import 'package:donor_app/core/helpers/spacing.dart';
import 'package:flutter/material.dart';

class GreetingSection extends StatelessWidget {
  const GreetingSection({
    super.key,
    required this.hospitalName,
    required this.username,
    required this.remainingDays,
  });
  final String username;
  final String hospitalName;
  final int remainingDays;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichText(
          text: TextSpan(
            text: context.localizations.welcome_back_home,
            style: context.textStyles.font30TextPrimaryExtraBold,
            children: [
              TextSpan(
                text: '\n$username',
                style: context.textStyles.font30PrimaryExtraBold,
              ),
            ],
          ),
        ),
        verticalSpace(12),
        Text(
          '${context.localizations.donation_impact_message(hospitalName)} ${context.localizations.next_donation_availability(remainingDays)}',
          style: context.textStyles.font18TextSecondaryRegular,
          maxLines: null,
        ),
      ],
    );
  }
}
