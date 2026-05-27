import 'package:donor_app/core/helpers/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PriorityTag extends StatelessWidget {
  const PriorityTag({super.key, required this.priority});
  final String priority;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        color: context.isDarkMode
            ? context.colors.iconActiveBackground.withAlpha(51)
            : context.colors.iconActiveBackground,
      ),
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 4.h),
      child: Text(
        priority,
        style: context.textStyles.font12PrimaryBold.copyWith(
          letterSpacing: 0.6,
        ),
      ),
    );
  }
}
