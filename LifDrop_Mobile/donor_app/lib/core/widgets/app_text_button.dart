import 'package:donor_app/core/helpers/extensions.dart';
import 'package:donor_app/core/helpers/spacing.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppTextButton extends StatelessWidget {
  const AppTextButton({
    super.key,
    required this.buttonText,
    this.horizontalPadding,
    this.verticalPadding,
    this.backgroundColor,
    required this.textStyle,
    this.borderRadius,
    this.buttonWidth,
    this.buttonHeight,
    required this.onPressed,
    this.isLoading = false,
    this.isIconRight = false,
    this.icon,
  });
  final Widget? icon;
  final String buttonText;
  final double? horizontalPadding;
  final double? verticalPadding;
  final Color? backgroundColor;
  final TextStyle textStyle;
  final double? borderRadius;
  final double? buttonWidth;
  final double? buttonHeight;
  final VoidCallback onPressed;
  final bool isLoading;
  final bool isIconRight;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: isLoading ? null : onPressed,
      style: TextButton.styleFrom(
        overlayColor: Colors.transparent,
        padding: EdgeInsets.symmetric(
          horizontal: horizontalPadding ?? 20.w,
          vertical: verticalPadding ?? 0.h,
        ),
        backgroundColor: backgroundColor ?? context.colors.primary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadius ?? 12.0),
        ),
        fixedSize: Size(buttonWidth ?? double.maxFinite, buttonHeight ?? 56.h),
      ),
      child: isLoading
          ? SizedBox(
              height: 20.h,
              width: 20.w,
              child: CircularProgressIndicator(
                strokeWidth: 2.w,
                valueColor: AlwaysStoppedAnimation<Color>(
                  textStyle.color ?? Colors.white,
                ),
              ),
            )
          : Row(
              mainAxisAlignment: .center,
              children: [
                if (!isIconRight) ?icon,
                if (icon != null && !isIconRight) horizontalSpace(8),
                Text(buttonText, style: textStyle),
                if (icon != null && isIconRight) horizontalSpace(8),
                if (isIconRight) ?icon,
              ],
            ),
    );
  }
}
