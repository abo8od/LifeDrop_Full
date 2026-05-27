import 'package:donor_app/core/helpers/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomToggle extends StatelessWidget {
  const CustomToggle({
    super.key,
    required this.isSelected,
    required this.onChanged,
    required this.activeColor,
  });

  final bool isSelected;
  final ValueChanged<bool> onChanged;
  final Color activeColor;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onChanged(!isSelected),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeInOut,
        width: 40.w,
        height: 20.h,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          color: isSelected ? activeColor : context.colors.surface,
        ),
        child: AnimatedAlign(
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeInOut,
          alignment: _getAlignment(context.isRTL),
          child: Container(
            margin: EdgeInsets.all(2.w),
            width: 16.w,
            height: 16.h,
            decoration: const BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
            ),
          ),
        ),
      ),
    );
  }

  Alignment _getAlignment(bool isRtl) {
    if (isRtl) {
      return isSelected ? Alignment.centerLeft : Alignment.centerRight;
    }
    return isSelected ? Alignment.centerRight : Alignment.centerLeft;
  }
}
