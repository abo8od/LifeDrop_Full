import 'package:donor_app/core/helpers/extensions.dart';
import 'package:donor_app/core/helpers/spacing.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

mixin SnackBarMixin {
  void showSuccessSnackBar(
    BuildContext context, {
    required String message,
    int? maxLines,
  }) {
    _showSnackBar(
      context,
      content: message,
      maxLines: maxLines,
      backgroundColor: Colors.green.withAlpha(150),
      style: context.textStyles.font12TextPrimaryBold,
      icon: Icons.info_outline,
    );
  }

  void showInfoSnackBar(
    BuildContext context, {
    required String message,
    int? maxLines,
  }) {
    _showSnackBar(
      context,
      content: message,
      backgroundColor: Colors.blue.withAlpha(150),
      maxLines: maxLines,
      icon: Icons.info_outline,
    );
  }

  void showErrorSnackBar(
    BuildContext context, {
    required String message,
    int? maxLines,
  }) {
    _showSnackBar(
      context,
      content: message,
      backgroundColor: context.colors.primary.withAlpha(150),
      maxLines: maxLines,
      icon: Icons.error_outline,
    );
  }

  void showSuccessSnackBarWithTitle(
    BuildContext context, {
    required String title,
    required String message,
    int? maxLines,
  }) {
    _showSnackBar(
      context,
      content: message,
      maxLines: maxLines,
      backgroundColor: Colors.green.withAlpha(150),
      icon: Icons.info_outline,
    );
  }

  void showErrorSnackBarWithTitle(
    BuildContext context, {
    required String title,
    required String message,
    int? maxLines,
  }) {
    _showSnackBar(
      context,
      content: message,
      backgroundColor: context.colors.primary.withAlpha(150),
      maxLines: maxLines,
      icon: Icons.error_outline,
    );
  }

  void _showSnackBar(
    BuildContext context, {
    String? title,
    required String content,
    required IconData icon,
    EdgeInsetsGeometry? margin,
    EdgeInsetsGeometry? padding,
    required Color backgroundColor,
    Color? iconColor,
    int? maxLines = 2,
    TextStyle? style,
  }) {
    ScaffoldMessenger.of(context)
      ..clearSnackBars()
      ..showSnackBar(
        SnackBar(
          duration: const Duration(seconds: 4),
          margin: margin,
          padding: padding,
          content: Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 15.h),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              color: backgroundColor,
            ),
            child: Row(
              children: [
                Icon(icon, color: iconColor ?? Colors.white, size: 30),
                horizontalSpace(8),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: .min,
                    children: [
                      if (title != null)
                        Text(
                          title,
                          style: context.textStyles.font12TextErrorBold,
                        ),
                      if (title != null) verticalSpace(4),
                      Text(
                        content,
                        style: style ?? context.textStyles.font12TextErrorBold,
                        overflow: maxLines != null
                            ? TextOverflow.ellipsis
                            : null,
                        maxLines: maxLines,
                        softWrap: true,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
      );
  }
}
