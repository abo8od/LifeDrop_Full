import 'package:donor_app/core/helpers/extensions.dart';
import 'package:donor_app/core/widgets/app_text_button.dart';
import 'package:flutter/material.dart';

class SaveChangesButton extends StatelessWidget {
  final VoidCallback onPressed;
  final bool isLoading;

  const SaveChangesButton({
    super.key,
    required this.onPressed,
    required this.isLoading,
  });

  @override
  Widget build(BuildContext context) {
    return AppTextButton(
      buttonText: context.localizations.save_changes,
      textStyle: context.textStyles.font16TextPrimaryBold.copyWith(
        color: Colors.white,
      ),
      isLoading: isLoading,
      onPressed: onPressed,
    );
  }
}
