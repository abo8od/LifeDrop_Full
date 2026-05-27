import 'package:donor_app/core/networking/api_constants.dart';

class AuthConstants {
  AuthConstants._();

  //-------------- Auth --------------

  static const String login = '${ApiConstants.auth}/login';
  static const String verifyOtp = '${ApiConstants.auth}/verify-otp';
  static const String sendOtp = '${ApiConstants.auth}/forgot-password';
  static const String resetPassword = '${ApiConstants.auth}/reset-password';
  static const String resendOtp = '${ApiConstants.auth}/resend-otp';
  static const String refreshToken = '${ApiConstants.auth}/refresh';

  //-------------- Location --------------

  static const String governorates = '${ApiConstants.locations}/governorates';
  static String districts(String governorateId) =>
      '$governorates/$governorateId/districts';

  //-------------- Donors --------------

  static const String register = '${ApiConstants.donors}/register';
  static const String verifyRegistration =
      '${ApiConstants.donors}/verify-registration';
  static const String resendRegistrationOtp =
      '${ApiConstants.donors}/resend-registration-otp';
}
