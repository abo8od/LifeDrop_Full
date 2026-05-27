import 'package:donor_app/core/helpers/extensions.dart';
import 'package:flutter/material.dart';

class TaglineText extends StatelessWidget {
  const TaglineText({super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      context.localizations.app_tagline,
      style: context.textStyles.font14SecondaryBold.copyWith(
        letterSpacing: 2.8,
      ),
    );
  }
}
