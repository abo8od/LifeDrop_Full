import 'package:donor_app/core/helpers/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BloodTypeOption extends StatelessWidget {
  const BloodTypeOption({
    super.key,
    required this.isSelected,
    required this.title,
    required this.onTap,
  });
  final String title;
  final bool isSelected;
  final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 16.w),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: context.isDarkMode
              ? isSelected
                    ? context.colors.primary.withAlpha(100)
                    : context.colors.surface
              : isSelected
              ? context.colors.iconActiveBackground
              : Colors.white,
          border: isSelected
              ? Border.all(
                  color: context.isDarkMode
                      ? context.colors.textError
                      : context.colors.primary,
                  width: 2,
                )
              : null,
        ),
        child: Text(
          title,
          style: context.isDarkMode
              ? isSelected
                    ? context.textStyles.font18PrimaryBold
                    : context.textStyles.font18TextPrimaryBold
              : isSelected
              ? context.textStyles.font18PrimaryBold
              : context.textStyles.font18TextPrimaryBold,
        ),
      ),
    );
  }
}
