import 'package:donor_app/core/helpers/extensions.dart';
import 'package:flutter/material.dart';

abstract class Validations {
  static String? validateEmail(BuildContext context, String email) {
    if (!email.isValidEmail || email.isEmpty) {
      return context.localizations.email_required;
    }
    return null;
  }

  static String? validatePassword(BuildContext context, String password) {
    if (!password.isValidPassword || password.isEmpty) {
      return context.localizations.password_required;
    }
    return null;
  }
}
