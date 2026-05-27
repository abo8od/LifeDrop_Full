import 'dart:async';
import 'dart:developer';

import 'package:donor_app/core/helpers/constants.dart';
import 'package:donor_app/core/helpers/shared_pref_helper.dart';
import 'package:donor_app/core/networking/api_constants.dart';
import 'package:donor_app/features/realtime/domain/entities/realtime_event.dart';
import 'package:signalr_netcore/signalr_client.dart';

class DonationsHubService {
  HubConnection? _connection;
  final StreamController<RealtimeEvent> _eventsController =
      StreamController<RealtimeEvent>.broadcast();

  Stream<RealtimeEvent> get events => _eventsController.stream;

  Future<void> connect() async {
    if (_connection?.state == HubConnectionState.Connected) return;

    final connection = HubConnectionBuilder()
        .withUrl(
          ApiConstants.donationsHub,
          options: HttpConnectionOptions(
            accessTokenFactory: () {
              return SharedPrefHelper.getSecuredString(
                SharedPrefKeys.accessToken,
              );
            },
          ),
        )
        .withAutomaticReconnect(retryDelays: [0, 2000, 5000, 10000, 30000])
        .build();

    _registerHandlers(connection);
    _connection = connection;

    try {
      await connection.start();
    } catch (error) {
      log('SignalR failed to start: $error');
    }
  }

  Future<void> disconnect() async {
    await _connection?.stop();
  }

  Future<void> refreshGroups() async {
    if (_connection?.state != HubConnectionState.Connected) return;
    await _connection?.invoke('RefreshGroups');
  }

  void _registerHandlers(HubConnection connection) {
    connection.on('NewDonationRequest', (arguments) {
      final data = _firstJsonArgument(arguments);
      if (data == null) return;
      _eventsController.add(NewDonationRequestEvent.fromJson(data));
    });

    connection.on('ActiveDonationUpdated', (arguments) {
      final data = _firstJsonArgument(arguments);
      if (data == null) return;
      _eventsController.add(ActiveDonationUpdatedEvent.fromJson(data));
    });

    connection.on('Notification', (arguments) {
      final data = _firstJsonArgument(arguments);
      if (data == null) return;
      _eventsController.add(RealtimeNotificationEvent.fromJson(data));
    });

    connection.on('ProfileUpdated', (arguments) async {
      await refreshGroups();
      _eventsController.add(const ProfileUpdatedEvent());
    });

    connection.onreconnected(({connectionId}) {
      _eventsController.add(const RealtimeReconnectedEvent());
    });

    connection.onclose(({error}) {
      log('SignalR closed: $error');
    });
  }

  Map<String, dynamic>? _firstJsonArgument(List<Object?>? arguments) {
    final data = arguments?.firstOrNull;
    if (data is Map<String, dynamic>) return data;
    if (data is Map) return Map<String, dynamic>.from(data);
    return null;
  }

  Future<void> dispose() async {
    await disconnect();
    await _eventsController.close();
  }
}
