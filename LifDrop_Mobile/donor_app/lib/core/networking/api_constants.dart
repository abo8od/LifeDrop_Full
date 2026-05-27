class ApiConstants {
  ApiConstants._();

  static const String baseUrl = 'https://lifedrop-vh2h.onrender.com/api';
  static const String realtimeBaseUrl = 'https://lifedrop-vh2h.onrender.com';

  static const String auth = '$baseUrl/auth';
  static const String refreshToken = '$auth/refresh';

  static const String donors = '$baseUrl/donors';
  static const String locations = '$baseUrl/locations';
  static const String donationRequests = '$baseUrl/donationRequests';
  static const String referenceData = '$baseUrl/referenceData';
  static const String notifications = '$baseUrl/notifications';
  static const String donationsHub = '$realtimeBaseUrl/hubs/donations';
}
