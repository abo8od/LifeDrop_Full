import 'package:donor_app/core/helpers/extensions.dart';
import 'package:donor_app/core/helpers/spacing.dart';
import 'package:flutter/material.dart';

class AuthTextSection extends StatelessWidget {
  const AuthTextSection({
    super.key,
    required this.title,
    required this.subtitle,
    this.titleStyle,
    this.subtitleStyle,
  });
  final String title;
  final String subtitle;
  final TextStyle? titleStyle;
  final TextStyle? subtitleStyle;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: .start,
      children: [
        Text(
          title,
          style:
              titleStyle ??
              context.textStyles.font48TextPrimaryExtraBold.copyWith(
                letterSpacing: -1.2,
              ),
        ),
        verticalSpace(1),
        Text(
          subtitle,
          style:
              subtitleStyle ??
              context.textStyles.font14SecondaryMedium.copyWith(
                letterSpacing: 0.35,
              ),
        ),
      ],
    );
  }
}
