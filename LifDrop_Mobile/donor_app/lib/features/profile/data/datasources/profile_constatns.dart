import 'package:donor_app/core/networking/api_constants.dart';

class ProfileConstatns {
  static const String profile = '${ApiConstants.donors}/me';
  static const String donationHistory = '$profile/history';
  static const String cooldown = '$profile/cooldown';
  static const String governorates = '${ApiConstants.locations}/governorates';
  static String districts(String governorateId) =>
      '$governorates/$governorateId/districts';
}
