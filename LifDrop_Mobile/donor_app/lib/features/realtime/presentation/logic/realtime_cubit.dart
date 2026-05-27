import 'dart:async';

import 'package:donor_app/features/realtime/data/services/donations_hub_service.dart';
import 'package:donor_app/features/realtime/domain/entities/realtime_event.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RealtimeState extends Equatable {
  const RealtimeState({this.event});

  final RealtimeEvent? event;

  @override
  List<Object?> get props => [event];
}

class RealtimeCubit extends Cubit<RealtimeState> {
  RealtimeCubit(this._hubService) : super(const RealtimeState());

  final DonationsHubService _hubService;
  StreamSubscription<RealtimeEvent>? _subscription;

  Future<void> connect() async {
    _subscription ??= _hubService.events.listen(
      (event) => emit(RealtimeState(event: event)),
    );
    await _hubService.connect();
  }

  Future<void> disconnect() async {
    await _subscription?.cancel();
    _subscription = null;
    await _hubService.disconnect();
  }

  @override
  Future<void> close() async {
    await disconnect();
    return super.close();
  }
}
