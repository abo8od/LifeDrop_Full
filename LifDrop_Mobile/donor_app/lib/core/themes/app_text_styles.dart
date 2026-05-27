import 'package:donor_app/core/themes/app_colors.dart';
import 'package:donor_app/core/themes/font_weight_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppTextStyles {
  final AppColors colors;

  AppTextStyles(this.colors);

  // ------------ 10 sp ------------

  TextStyle get font10TextSecondaryRegular => TextStyle(
    fontSize: 10.sp,
    fontWeight: FontWeightHelper.regular,
    color: colors.textSecondary,
  );
  TextStyle get font10TextSecondaryBold => TextStyle(
    fontSize: 10.sp,
    fontWeight: FontWeightHelper.bold,
    color: colors.textSecondary,
  );

  TextStyle get font10TextSecondaryRegular60Faded => TextStyle(
    fontSize: 10.sp,
    fontWeight: FontWeightHelper.regular,
    color: colors.textSecondary.withAlpha(153),
  );

  TextStyle get font10SecondaryBold => TextStyle(
    fontSize: 10.sp,
    fontWeight: FontWeightHelper.bold,
    color: colors.secondary,
  );
  TextStyle get font10SecondarySemiBold => TextStyle(
    fontSize: 10.sp,
    fontWeight: FontWeightHelper.semiBold,
    color: colors.secondary,
  );
  TextStyle get font10TextPlaceHolderBold40Faded => TextStyle(
    fontSize: 10.sp,
    fontWeight: FontWeightHelper.bold,
    color: colors.textPlaceHolder.withAlpha(102),
  );
  TextStyle get font10TextPlaceHolderBold => TextStyle(
    fontSize: 10.sp,
    fontWeight: FontWeightHelper.bold,
    color: colors.textPlaceHolder,
  );
  TextStyle get font10IconActiveBold => TextStyle(
    fontSize: 10.sp,
    fontWeight: FontWeightHelper.bold,
    color: colors.iconActive,
  );
  TextStyle get font10IconInactiveBold => TextStyle(
    fontSize: 10.sp,
    fontWeight: FontWeightHelper.bold,
    color: colors.iconInactive,
  );
  TextStyle get font10PrimaryBold => TextStyle(
    fontSize: 10.sp,
    fontWeight: FontWeightHelper.bold,
    color: colors.primary,
  );
  TextStyle get font10TertiaryBold => TextStyle(
    fontSize: 10.sp,
    fontWeight: FontWeightHelper.bold,
    color: colors.tertiary,
  );

  // ------------ 12 sp ------------

  TextStyle get font12TextSecondaryRegular => TextStyle(
    fontSize: 12.sp,
    fontWeight: FontWeightHelper.regular,
    color: colors.textSecondary,
  );
  TextStyle get font12TextSecondaryMedium => TextStyle(
    fontSize: 12.sp,
    fontWeight: FontWeightHelper.medium,
    color: colors.textSecondary,
  );
  TextStyle get font12TextSecondaryBold => TextStyle(
    fontSize: 12.sp,
    fontWeight: FontWeightHelper.bold,
    color: colors.textSecondary,
  );
  TextStyle get font12TextPlaceHolderRegular => TextStyle(
    fontSize: 12.sp,
    fontWeight: FontWeightHelper.regular,
    color: colors.textPlaceHolder,
  );
  TextStyle get font12TextPlaceHolderMedium => TextStyle(
    fontSize: 12.sp,
    fontWeight: FontWeightHelper.medium,
    color: colors.textPlaceHolder,
  );

  TextStyle get font12SecondarySemiBold => TextStyle(
    fontSize: 12.sp,
    fontWeight: FontWeightHelper.semiBold,
    color: colors.secondary,
  );
  TextStyle get font12SecondaryBold => TextStyle(
    fontSize: 12.sp,
    fontWeight: FontWeightHelper.bold,
    color: colors.secondary,
  );
  TextStyle get font12TextPrimaryMedium => TextStyle(
    fontSize: 12.sp,
    fontWeight: FontWeightHelper.medium,
    color: colors.textPrimary,
  );
  TextStyle get font12TextErrorBold => TextStyle(
    fontSize: 12.sp,
    fontWeight: FontWeightHelper.bold,
    color: colors.textError,
  );
  TextStyle get font12TextPrimaryBold => TextStyle(
    fontSize: 12.sp,
    fontWeight: FontWeightHelper.bold,
    color: colors.textPrimary,
  );
  TextStyle get font12PrimaryBold => TextStyle(
    fontSize: 12.sp,
    fontWeight: FontWeightHelper.bold,
    color: colors.primary,
  );
  TextStyle get font12WhiteBold => TextStyle(
    fontSize: 12.sp,
    fontWeight: FontWeightHelper.bold,
    color: Colors.white,
  );

  // ------------ 14 sp ------------

  TextStyle get font14SecondaryBold => TextStyle(
    fontSize: 14.sp,
    fontWeight: FontWeightHelper.bold,
    color: colors.secondary,
  );
  TextStyle get font14PrimaryBold => TextStyle(
    fontSize: 14.sp,
    fontWeight: FontWeightHelper.bold,
    color: colors.primary,
  );
  TextStyle get font14PrimaryRegular => TextStyle(
    fontSize: 14.sp,
    fontWeight: FontWeightHelper.regular,
    color: colors.primary,
  );
  TextStyle get font14WhiteBold => TextStyle(
    fontSize: 14.sp,
    fontWeight: FontWeightHelper.bold,
    color: Colors.white,
  );
  TextStyle get font14SecondarySemiBold => TextStyle(
    fontSize: 14.sp,
    fontWeight: FontWeightHelper.semiBold,
    color: colors.secondary,
  );
  TextStyle get font14SecondaryMedium => TextStyle(
    fontSize: 14.sp,
    fontWeight: FontWeightHelper.medium,
    color: colors.secondary,
  );
  TextStyle get font14TextSecondaryRegular => TextStyle(
    fontSize: 14.sp,
    fontWeight: FontWeightHelper.regular,
    color: colors.textSecondary,
  );
  TextStyle get font14TextPlaceHolderRegular => TextStyle(
    fontSize: 14.sp,
    fontWeight: FontWeightHelper.regular,
    color: colors.textPlaceHolder,
  );
  TextStyle get font14TextPrimaryRegular => TextStyle(
    fontSize: 14.sp,
    fontWeight: FontWeightHelper.regular,
    color: colors.textPrimary,
  );
  TextStyle get font14TextPrimaryBold => TextStyle(
    fontSize: 14.sp,
    fontWeight: FontWeightHelper.bold,
    color: colors.textPrimary,
  );
  TextStyle get font14TextPrimarySemiBold => TextStyle(
    fontSize: 14.sp,
    fontWeight: FontWeightHelper.semiBold,
    color: colors.textPrimary,
  );
  TextStyle get font14TextPrimaryMedium => TextStyle(
    fontSize: 14.sp,
    fontWeight: FontWeightHelper.medium,
    color: colors.textPrimary,
  );
  TextStyle get font14WhiteRegular => TextStyle(
    fontSize: 14.sp,
    fontWeight: FontWeightHelper.regular,
    color: Colors.white,
  );
  TextStyle get font14BlackRegular => TextStyle(
    fontSize: 14.sp,
    fontWeight: FontWeightHelper.regular,
    color: Colors.black,
  );

  // ------------ 15 sp ------------

  TextStyle get font15TextPrimaryRegular => TextStyle(
    fontSize: 15.sp,
    fontWeight: FontWeightHelper.regular,
    color: colors.textPrimary,
  );

  // ------------ 16 sp ------------

  TextStyle get font16SecondaryMedium => TextStyle(
    fontSize: 16.sp,
    fontWeight: FontWeightHelper.medium,
    color: colors.secondary,
  );
  TextStyle get font16TextSecondaryMedium => TextStyle(
    fontSize: 16.sp,
    fontWeight: FontWeightHelper.medium,
    color: colors.textSecondary,
  );
  TextStyle get font16TextSecondaryRegular => TextStyle(
    fontSize: 16.sp,
    fontWeight: FontWeightHelper.regular,
    color: colors.textSecondary,
  );
  TextStyle get font16TextPlaceHolderMedium50Faded => TextStyle(
    fontSize: 16.sp,
    fontWeight: FontWeightHelper.medium,
    color: colors.textPlaceHolder.withAlpha(125),
  );
  TextStyle get font16SecondaryBold => TextStyle(
    fontSize: 16.sp,
    fontWeight: FontWeightHelper.bold,
    color: colors.secondary,
  );
  TextStyle get font16TextPrimaryBold => TextStyle(
    fontSize: 16.sp,
    fontWeight: FontWeightHelper.bold,
    color: colors.textPrimary,
  );
  TextStyle get font16TextPrimaryMedium => TextStyle(
    fontSize: 16.sp,
    fontWeight: FontWeightHelper.medium,
    color: colors.textPrimary,
  );
  TextStyle get font16TextSecondaryBold => TextStyle(
    fontSize: 16.sp,
    fontWeight: FontWeightHelper.bold,
    color: colors.textSecondary,
  );
  TextStyle get font16PrimaryBold => TextStyle(
    fontSize: 16.sp,
    fontWeight: FontWeightHelper.bold,
    color: colors.primary,
  );
  TextStyle get font16WhiteBold => TextStyle(
    fontSize: 16.sp,
    fontWeight: FontWeightHelper.bold,
    color: Colors.white,
  );

  // ------------ 18 sp ------------

  TextStyle get font18WhiteBold => TextStyle(
    fontSize: 18.sp,
    fontWeight: FontWeightHelper.bold,
    color: Colors.white,
  );
  TextStyle get font18TextPrimaryBold => TextStyle(
    fontSize: 18.sp,
    fontWeight: FontWeightHelper.bold,
    color: colors.textPrimary,
  );
  TextStyle get font18TextSecondaryRegular => TextStyle(
    fontSize: 18.sp,
    fontWeight: FontWeightHelper.regular,
    color: colors.textSecondary,
  );
  TextStyle get font18PrimaryBold => TextStyle(
    fontSize: 18.sp,
    fontWeight: FontWeightHelper.bold,
    color: colors.primary,
  );

  // ------------ 20 sp ------------

  TextStyle get font20TextPrimaryBold => TextStyle(
    fontSize: 20.sp,
    fontWeight: FontWeightHelper.bold,
    color: colors.textPrimary,
  );
  TextStyle get font20PrimaryExtraBold => TextStyle(
    fontSize: 20.sp,
    fontWeight: FontWeightHelper.extraBold,
    color: colors.primary,
  );
  TextStyle get font20SecondaryExtraBold => TextStyle(
    fontSize: 20.sp,
    fontWeight: FontWeightHelper.extraBold,
    color: colors.secondary,
  );

  // ------------ 24 sp ------------

  TextStyle get font24TextPrimaryBold => TextStyle(
    fontSize: 24.sp,
    fontWeight: FontWeightHelper.bold,
    color: colors.textPrimary,
  );
  TextStyle get font24TextPrimaryExtraBold => TextStyle(
    fontSize: 24.sp,
    fontWeight: FontWeightHelper.extraBold,
    color: colors.textPrimary,
  );
  TextStyle get font24PrimaryExtraBold => TextStyle(
    fontSize: 24.sp,
    fontWeight: FontWeightHelper.extraBold,
    color: colors.primary,
  );
  TextStyle get font24SecondaryExtraBold => TextStyle(
    fontSize: 24.sp,
    fontWeight: FontWeightHelper.extraBold,
    color: colors.secondary,
  );
  TextStyle get font24SecondaryBold => TextStyle(
    fontSize: 24.sp,
    fontWeight: FontWeightHelper.bold,
    color: colors.secondary,
  );

  // ------------ 30 sp ------------

  TextStyle get font30TextPrimaryExtraBold => TextStyle(
    fontSize: 30.sp,
    fontWeight: FontWeightHelper.extraBold,
    color: colors.textPrimary,
  );
  TextStyle get font30PrimaryExtraBold => TextStyle(
    fontSize: 30.sp,
    fontWeight: FontWeightHelper.extraBold,
    color: colors.primary,
  );

  // ------------ 36 sp ------------

  TextStyle get font36TextPrimaryExtraBold => TextStyle(
    fontSize: 36.sp,
    fontWeight: FontWeightHelper.extraBold,
    color: colors.textPrimary,
  );
  TextStyle get font36PrimaryExtraBold => TextStyle(
    fontSize: 36.sp,
    fontWeight: FontWeightHelper.extraBold,
    color: colors.primary,
  );

  // ------------ 48 sp ------------

  TextStyle get font48PrimaryExtraBold => TextStyle(
    fontSize: 48.sp,
    fontWeight: FontWeightHelper.extraBold,
    color: colors.primary,
  );
  TextStyle get font48TextPrimaryExtraBold => TextStyle(
    fontSize: 48.sp,
    fontWeight: FontWeightHelper.extraBold,
    color: colors.textPrimary,
  );

  // ------------ 60 sp ------------

  TextStyle get font60TextPrimaryExtraBold => TextStyle(
    fontSize: 60.sp,
    fontWeight: FontWeightHelper.extraBold,
    color: colors.textPrimary,
  );
}
