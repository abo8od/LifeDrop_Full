import 'package:donor_app/core/helpers/extensions.dart';
import 'package:donor_app/core/helpers/spacing.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ImpactWarningCard extends StatelessWidget {
  const ImpactWarningCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: context.colors.neutral,
        borderRadius: BorderRadius.circular(12),
      ),
      padding: EdgeInsets.symmetric(vertical: 32.h, horizontal: 32.w),
      child: Row(
        crossAxisAlignment: .start,
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: Colors.red[200],
            ),
            padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 12.w),
            child: Icon(Icons.warning, color: context.colors.primary),
          ),
          horizontalSpace(24),
          Expanded(
            child: Column(
              crossAxisAlignment: .start,
              children: [
                Text(
                  context.localizations.impact_on_reliability,
                  style: context.textStyles.font20TextPrimaryBold.copyWith(
                    letterSpacing: 0,
                  ),
                ),
                verticalSpace(8),
                Text(
                  context.localizations.cancellation_impact_message,
                  style: context.textStyles.font16TextSecondaryMedium.copyWith(
                    letterSpacing: 0,
                  ),
                  // softWrap: true,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
