import 'package:donor_app/core/helpers/extensions.dart';
import 'package:donor_app/core/helpers/spacing.dart';
import 'package:donor_app/features/donation_request/presentation/widgets/priority_tag.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CriticalRequestBanner extends StatelessWidget {
  const CriticalRequestBanner({
    super.key,
    required this.requestHeadline,
    required this.priority,
    required this.hospitalName,
    required this.bloodType,
  });
  final String requestHeadline;
  final String priority;
  final String hospitalName;
  final String bloodType;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: context.colors.neutral,
      ),
      padding: EdgeInsetsGeometry.symmetric(vertical: 28.h, horizontal: 32.w),
      child: Column(
        crossAxisAlignment: .start,
        children: [
          PriorityTag(priority: priority),
          verticalSpace(5),
          Text(
            requestHeadline,
            style: context.textStyles.font30TextPrimaryExtraBold,
          ),
          verticalSpace(5),
          Text(hospitalName, style: context.textStyles.font16SecondaryMedium),
          verticalSpace(10),
          CircleAvatar(
            radius: 45,
            backgroundColor: context.isDarkMode
                ? context.colors.iconActiveBackground.withAlpha(51)
                : context.colors.iconActiveBackground,
            child: CircleAvatar(
              backgroundColor: context.colors.navigationBar,
              radius: 40,
              child: Text(
                bloodType,
                style: context.textStyles.font30PrimaryExtraBold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
