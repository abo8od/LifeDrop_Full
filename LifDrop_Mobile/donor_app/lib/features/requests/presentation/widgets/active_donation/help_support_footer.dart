import 'package:donor_app/core/helpers/extensions.dart';
import 'package:donor_app/core/helpers/spacing.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HelpSupportFooter extends StatelessWidget {
  const HelpSupportFooter({super.key});

  @override
  Widget build(BuildContext context) {
    final secondaryDark = const Color(0xFF064C6B);

    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: context.colors.surface.withAlpha(127),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.info_outline, size: 20.sp, color: secondaryDark),
          horizontalSpace(16),
          Expanded(
            child: RichText(
              text: TextSpan(
                style: context.textStyles.font12TextSecondaryRegular.copyWith(
                  color: secondaryDark,
                  height: 1.625,
                ),
                children: [
                  const TextSpan(
                    text: 'Need assistance? Use the contact button\nabove or ',
                  ),
                  TextSpan(
                    text: 'view donation guidelines',
                    style: context.textStyles.font12TextSecondaryRegular
                        .copyWith(
                          color: secondaryDark,
                          fontWeight: FontWeight.w700,
                          decoration: TextDecoration.underline,
                          height: 1.625,
                        ),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        // TODO: Navigate to donation guidelines
                      },
                  ),
                  const TextSpan(text: '.'),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
