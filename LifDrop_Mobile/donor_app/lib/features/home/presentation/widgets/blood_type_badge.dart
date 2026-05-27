import 'package:donor_app/core/helpers/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BloodTypeBadge extends StatelessWidget {
  const BloodTypeBadge({
    super.key,
    required this.bloodType,
    required this.isUrgent,
  });
  final String bloodType;
  final bool isUrgent;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: context.isDarkMode
            ? isUrgent
                  ? context.colors.iconActiveBackground.withAlpha(51)
                  : context.colors.tertiary
            : isUrgent
            ? context.colors.iconActiveBackground
            : context.colors.tertiary,
      ),
      padding: EdgeInsets.symmetric(vertical: 15.h, horizontal: 15.w),
      child: Text(
        bloodType,
        style: isUrgent
            ? context.textStyles.font20PrimaryExtraBold
            : context.textStyles.font20SecondaryExtraBold,
      ),
    );
  }
}
