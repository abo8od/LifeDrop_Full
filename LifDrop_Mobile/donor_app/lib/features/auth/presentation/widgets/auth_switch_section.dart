import 'package:donor_app/core/helpers/extensions.dart';
import 'package:donor_app/core/helpers/spacing.dart';
import 'package:flutter/material.dart';

class AuthSwitchSection extends StatelessWidget {
  const AuthSwitchSection({
    super.key,
    required this.text,
    required this.actionText,
    required this.onTap,
  });
  final String text;
  final String actionText;
  final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: .center,
      children: [
        Text(text, style: context.textStyles.font14TextSecondaryRegular),
        horizontalSpace(8),
        GestureDetector(
          onTap: onTap,
          child: Text(actionText, style: context.textStyles.font14PrimaryBold),
        ),
      ],
    );
  }
}
