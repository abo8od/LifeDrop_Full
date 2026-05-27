import 'package:donor_app/core/networking/api_constants.dart';

class DonationRequestConstants {
  DonationRequestConstants._();

  static String requestDetails(String requestId) =>
      '${ApiConstants.donationRequests}/$requestId/details';

  static String acceptRequest(String requestId) =>
      '${ApiConstants.donationRequests}/$requestId/accept';
}
