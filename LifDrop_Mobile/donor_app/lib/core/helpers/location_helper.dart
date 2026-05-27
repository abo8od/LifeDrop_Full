import 'dart:developer';

import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:url_launcher/url_launcher.dart';

class LocationHelper {
  static Future<void> openCoordinates(double lat, double lng) async {
    final Uri url = Uri.parse(
      'https://www.google.com/maps/search/?api=1&query=$lat,$lng',
    );

    await launchUrl(url, mode: LaunchMode.externalApplication);
  }

  static Future<void> openDirections(double lat, double lng) async {
    final Uri url = Uri.parse(
      'https://www.google.com/maps/dir/?api=1&destination=$lat,$lng',
    );

    await launchUrl(url, mode: LaunchMode.externalApplication);
  }

  static Future<String> getAddressFromLatLng(double lat, double lng) async {
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(lat, lng);

      final place = placemarks.first;

      log("${place.street}, ${place.subLocality}, ${place.locality}");

      return "${place.street}, ${place.subLocality}, ${place.locality}";
    } catch (e, stack) {
      FirebaseCrashlytics.instance.log("""
      Get Map Address Error:
      Errors: ${e.toString()}
      """);

      FirebaseCrashlytics.instance.recordError(e, stack);
      return "Address not found";
    }
  }

  static Future<String> getDistance(
    double hospitalLat,
    double hospitalLng,
  ) async {
    try {
      LocationPermission permission = await Geolocator.checkPermission();

      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();

        if (permission == LocationPermission.denied) {
          return "Enable location";
        }
      }

      if (permission == LocationPermission.deniedForever) {
        return "Enable location in settings";
      }

      final position = await Geolocator.getCurrentPosition(
        locationSettings: AndroidSettings(accuracy: LocationAccuracy.best),
      );

      final distanceInMeters = Geolocator.distanceBetween(
        position.latitude,
        position.longitude,
        hospitalLat,
        hospitalLng,
      );

      if (distanceInMeters < 1000) {
        return "${distanceInMeters.toInt()} m away";
      } else {
        return "${(distanceInMeters / 1000).toStringAsFixed(1)} km away";
      }
    } catch (e, stack) {
      FirebaseCrashlytics.instance.log("""
      Get Distance Error:
      Errors: ${e.toString()}
      """);

      FirebaseCrashlytics.instance.recordError(e, stack);
      return '0 km away';
    }
  }

  static Future<void> requestLocationPermission() async {
    LocationPermission permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }
    if (permission == LocationPermission.deniedForever) {
      await Geolocator.openAppSettings();
    }
  }
}
