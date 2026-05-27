import 'package:donor_app/core/themes/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

ThemeData lightTheme() {
  final colors = AppColors.light();
  return ThemeData(
    scaffoldBackgroundColor: colors.background,
    brightness: Brightness.light,
    extensions: [AppColors.light()],
    inputDecorationTheme: InputDecorationTheme(
      fillColor: colors.surface,
      filled: true,
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(width: 1, color: colors.neutral),
      ),
      prefixIconConstraints: BoxConstraints(
        maxHeight: 40.h,
        maxWidth: 100.w,
        minHeight: 16.h,
        minWidth: 16.w,
      ),
      contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 15.h),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(color: colors.textError.withAlpha(76), width: 1),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(color: colors.secondary.withAlpha(76), width: 1),
      ),
    ),
  );
}

ThemeData darkTheme() {
  final colors = AppColors.dark();
  return ThemeData(
    scaffoldBackgroundColor: colors.background,
    brightness: Brightness.dark,
    extensions: [AppColors.dark()],
    inputDecorationTheme: InputDecorationTheme(
      fillColor: colors.surface,
      filled: true,
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(width: 1, color: colors.neutral),
      ),
      prefixIconConstraints: BoxConstraints(
        maxHeight: 40.h,
        maxWidth: 100.w,
        minHeight: 16.h,
        minWidth: 16.w,
      ),
      contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(color: colors.textError.withAlpha(76), width: 1),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(color: colors.secondary.withAlpha(76), width: 1),
      ),
    ),
  );
}
