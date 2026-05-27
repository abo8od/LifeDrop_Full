import 'package:donor_app/core/themes/app_colors.dart';
import 'package:donor_app/core/themes/app_text_styles.dart';
import 'package:donor_app/core/enums/blood_type.dart';
import 'package:donor_app/l10n/app_localizations.dart';
import 'package:flutter/material.dart';

extension ThemeExtension on BuildContext {
  AppColors get colors => Theme.of(this).extension<AppColors>()!;
}

extension TextStyleExtension on BuildContext {
  AppTextStyles get textStyles => AppTextStyles(colors);
}

extension ModeExtension on BuildContext {
  bool get isDarkMode => Theme.of(this).brightness == Brightness.dark;
}

extension Direction on BuildContext {
  bool get isRTL => Directionality.of(this) == TextDirection.rtl;
}

extension Localizations on BuildContext {
  AppLocalizations get localizations => AppLocalizations.of(this)!;
  bool get isArabic => localizations.localeName == 'ar';
}

extension Navigation on BuildContext {
  Future<dynamic> pushNamed(String routeName, {Object? arguments}) {
    return Navigator.of(this).pushNamed(routeName, arguments: arguments);
  }

  Future<dynamic> pushReplacementNamed(String routeName, {Object? arguments}) {
    return Navigator.of(
      this,
    ).pushReplacementNamed(routeName, arguments: arguments);
  }

  Future<dynamic> pushNamedAndRemoveUntil(
    String routeName, {
    Object? arguments,
    required RoutePredicate predicate,
  }) {
    return Navigator.of(
      this,
    ).pushNamedAndRemoveUntil(routeName, predicate, arguments: arguments);
  }

  void pop<T>({T? value}) => Navigator.of(this).pop<T?>(value);
}

extension ValidationsString on String {
  bool get isValidEmail =>
      RegExp(r'^[a-zA-Z0-9_]+@[a-zA-Z0-9]+\.[a-zA-Z]+$').hasMatch(this);

  bool get isValidPassword => RegExp(
    r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[^a-zA-Z0-9])(?=\S+$).{8,}$',
  ).hasMatch(this);

  bool get isDigitsOnly => RegExp(r'^\d+$').hasMatch(this);

  bool get isValidJordanPhoneNumber =>
      RegExp(r'^0?7[789]\d{7}$').hasMatch(this);
}

extension FormatString on String {
  String formatPhoneNumberJO() {
    String phone = trim();

    phone = phone.replaceAll(RegExp(r'\D'), '');

    if (phone.startsWith('962')) {
      phone = phone.substring(3);
    }
    if (phone.startsWith('0')) {
      phone = phone.substring(1);
    }
    return '+962$phone';
  }
}

extension BloodTypeDisplay on BloodType {
  String get label {
    switch (this) {
      case BloodType.O_Positive:
        return 'O+';
      case BloodType.O_Negative:
        return 'O-';
      case BloodType.A_Positive:
        return 'A+';
      case BloodType.A_Negative:
        return 'A-';
      case BloodType.B_Positive:
        return 'B+';
      case BloodType.B_Negative:
        return 'B-';
      case BloodType.AB_Positive:
        return 'AB+';
      case BloodType.AB_Negative:
        return 'AB-';
    }
  }
}
