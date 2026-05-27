import 'package:donor_app/core/helpers/extensions.dart';
import 'package:flutter/material.dart';

class RequestsSection extends StatelessWidget {
  const RequestsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      context.localizations.active_requests,
      style: context.textStyles.font24TextPrimaryBold,
    );
  }
}
