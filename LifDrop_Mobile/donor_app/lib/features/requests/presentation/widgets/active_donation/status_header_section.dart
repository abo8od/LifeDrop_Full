import 'package:donor_app/core/helpers/extensions.dart';
import 'package:flutter/material.dart';

class StatusHeaderSection extends StatefulWidget {
  const StatusHeaderSection({super.key});

  @override
  State<StatusHeaderSection> createState() => _StatusHeaderSectionState();
}

class _StatusHeaderSectionState extends State<StatusHeaderSection> {
  @override
  Widget build(BuildContext context) {
    return Text(
      context.localizations.donation_progress,
      style: context.textStyles.font36TextPrimaryExtraBold.copyWith(
        letterSpacing: -0.9,
      ),
    );
  }
}
