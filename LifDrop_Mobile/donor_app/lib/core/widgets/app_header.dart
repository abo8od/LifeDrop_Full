import 'package:donor_app/core/helpers/spacing.dart';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppHeader extends StatelessWidget {
  const AppHeader({
    super.key,
    required this.icon,
    required this.title,
    required this.style,
    this.padding,
  });
  final Widget icon;
  final String title;
  final TextStyle style;
  final EdgeInsetsGeometry? padding;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding ?? EdgeInsets.symmetric(vertical: 16.h),
      child: Row(
        children: [
          icon,
          horizontalSpace(8),
          Text(title, style: style),
        ],
      ),
    );
  }
}
