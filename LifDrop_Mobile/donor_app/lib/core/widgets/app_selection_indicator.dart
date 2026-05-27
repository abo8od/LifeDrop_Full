import 'package:donor_app/core/helpers/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppSelectionIndicator extends StatelessWidget {
  const AppSelectionIndicator({
    super.key,
    required this.isSelected,
    this.size,
    this.onTap,
  });
  final double? size;
  final bool isSelected;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: (size ?? 20).h,
        width: (size ?? 20).w,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(
            color: isSelected
                ? context.colors.primary
                : context.colors.textSecondary.withAlpha(80),
            width: isSelected ? 2.w : 1.5.w,
          ),
        ),
        padding: EdgeInsets.all(3.w),
        child: isSelected
            ? Container(
                decoration: BoxDecoration(
                  color: context.colors.primary,
                  shape: BoxShape.circle,
                ),
              )
            : null,
      ),
    );
  }
}
