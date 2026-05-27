import 'package:donor_app/core/helpers/extensions.dart';
import 'package:donor_app/core/helpers/spacing.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DonationSummary extends StatelessWidget {
  const DonationSummary({super.key, required this.totalDonations});
  final int totalDonations;

  String donationsCount(BuildContext context, int count) {
    if (count >= 3 && count <= 10) {
      return context.localizations.tens_donation;
    }
    return context.localizations.donations;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: context.colors.neutral,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Stack(
        children: [
          Positioned(
            right: context.isRTL ? null : -25.w,
            left: context.isRTL ? -25.w : null,
            bottom: -28.h,
            child: Icon(
              Icons.favorite,
              size: 120,
              color: Colors.grey.withAlpha(51),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 32.w, vertical: 32.h),
            child: Column(
              crossAxisAlignment: .start,
              children: [
                Text(
                  context.localizations.total_contributions,
                  style: context.textStyles.font12PrimaryBold.copyWith(
                    letterSpacing: 0.6,
                  ),
                ),
                verticalSpace(8),
                RichText(
                  text: TextSpan(
                    text: totalDonations.toString(),
                    style: context.textStyles.font60TextPrimaryExtraBold,
                    children: [
                      WidgetSpan(child: horizontalSpace(8)),
                      TextSpan(
                        text: donationsCount(context, totalDonations),
                        style: context.textStyles.font16TextSecondaryMedium,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
