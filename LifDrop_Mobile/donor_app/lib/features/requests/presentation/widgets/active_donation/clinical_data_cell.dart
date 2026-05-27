import 'package:donor_app/core/helpers/extensions.dart';
import 'package:donor_app/core/helpers/spacing.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ClinicalDataCell extends StatelessWidget {
  const ClinicalDataCell({
    super.key,
    required this.label,
    required this.icon,
    required this.value,
    this.valueColor,
  });

  final String label;
  final IconData icon;
  final String value;
  final Color? valueColor;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: context.textStyles.font10TextSecondaryBold.copyWith(
            letterSpacing: 1,
          ),
        ),
        verticalSpace(4),
        Row(
          children: [
            Icon(
              icon,
              size: 12.sp,
              color: valueColor ?? context.colors.textPrimary,
            ),
            horizontalSpace(8),
            Expanded(
              child: Text(
                value,
                style: context.textStyles.font16TextPrimaryBold.copyWith(
                  color: valueColor,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
