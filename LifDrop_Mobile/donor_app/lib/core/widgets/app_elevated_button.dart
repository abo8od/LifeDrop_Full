import 'package:donor_app/core/helpers/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppElevatedButton extends StatelessWidget {
  const AppElevatedButton({
    super.key,
    required this.isLoading,
    required this.onPressed,
    required this.title,
    this.buttonColors,
    this.style,
  });
  final bool isLoading;
  final String title;
  final TextStyle? style;
  final Color? buttonColors;
  final void Function() onPressed;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: isLoading ? () {} : onPressed,
      style: ElevatedButton.styleFrom(
        overlayColor: Colors.transparent,
        backgroundColor: buttonColors ?? context.colors.primary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
        fixedSize: Size(double.maxFinite, 56.h),
      ),

      child: isLoading
          ? SizedBox(
              height: 20.h,
              width: 20.w,
              child: CircularProgressIndicator(
                strokeWidth: 2.w,
                valueColor: AlwaysStoppedAnimation<Color>(
                  style?.color ?? Colors.white,
                ),
              ),
            )
          : Text(title, style: style ?? context.textStyles.font16WhiteBold),
    );
  }
}
