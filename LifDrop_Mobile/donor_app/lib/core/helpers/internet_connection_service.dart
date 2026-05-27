import 'dart:async';
import 'dart:io';

class InternetConnectionService {
  const InternetConnectionService();

  Future<bool> hasConnection() async {
    try {
      final result = await InternetAddress.lookup(
        'example.com',
      ).timeout(const Duration(seconds: 3));

      return result.isNotEmpty && result.first.rawAddress.isNotEmpty;
    } on SocketException {
      return false;
    } on TimeoutException {
      return false;
    }
  }

  Stream<bool> watchConnection({
    Duration interval = const Duration(seconds: 2),
  }) async* {
    bool? previousStatus;

    while (true) {
      final currentStatus = await hasConnection();

      if (currentStatus != previousStatus) {
        previousStatus = currentStatus;
        yield currentStatus;
      }

      await Future.delayed(interval);
    }
  }

  Future<void> waitForConnection({
    Duration interval = const Duration(seconds: 2),
  }) async {
    while (!await hasConnection()) {
      await Future.delayed(interval);
    }
  }
}
