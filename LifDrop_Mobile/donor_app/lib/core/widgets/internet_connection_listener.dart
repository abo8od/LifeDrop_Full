import 'dart:async';

import 'package:donor_app/core/di/injection_container.dart';
import 'package:donor_app/core/helpers/internet_connection_service.dart';
import 'package:donor_app/features/disconnected/presentation/screens/disconnected_screen.dart';
import 'package:flutter/material.dart';

class InternetConnectionListener extends StatefulWidget {
  const InternetConnectionListener({super.key, required this.child});

  final Widget child;

  @override
  State<InternetConnectionListener> createState() =>
      _InternetConnectionListenerState();
}

class _InternetConnectionListenerState
    extends State<InternetConnectionListener> {
  final InternetConnectionService _internetConnectionService =
      const InternetConnectionService();
  StreamSubscription<bool>? _connectionSubscription;
  Route<void>? _disconnectedRoute;
  bool _isDisconnectedScreenVisible = false;

  @override
  void initState() {
    super.initState();
    _connectionSubscription = _internetConnectionService
        .watchConnection()
        .listen(_handleConnectionStatus);
  }

  void _handleConnectionStatus(bool hasConnection) {
    if (!mounted) return;

    if (hasConnection) {
      _hideDisconnectedScreen();
      return;
    }

    _showDisconnectedScreen();
  }

  void _showDisconnectedScreen() {
    if (_isDisconnectedScreenVisible) return;

    final navigator = navigatorKey.currentState;
    if (navigator == null) return;

    final route = MaterialPageRoute<void>(
      builder: (context) =>
          DisconnectedScreen(onReconnect: _hideDisconnectedScreen),
    );

    _disconnectedRoute = route;
    _isDisconnectedScreenVisible = true;
    navigator.push(route).whenComplete(() {
      _disconnectedRoute = null;
      _isDisconnectedScreenVisible = false;
    });
  }

  void _hideDisconnectedScreen() {
    if (!_isDisconnectedScreenVisible) return;

    final navigator = navigatorKey.currentState;
    final disconnectedRoute = _disconnectedRoute;
    if (navigator == null || disconnectedRoute == null) return;

    navigator.removeRoute(disconnectedRoute);
  }

  @override
  void dispose() {
    _connectionSubscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => widget.child;
}
