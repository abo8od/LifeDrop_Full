import 'package:equatable/equatable.dart';

sealed class RealtimeEvent extends Equatable {
  const RealtimeEvent();

  @override
  List<Object?> get props => [];
}

final class NewDonationRequestEvent extends RealtimeEvent {
  const NewDonationRequestEvent({
    required this.requestId,
    required this.title,
    required this.body,
    required this.type,
    required this.urgency,
    required this.requiredBloodType,
    required this.hospitalName,
    required this.expiryDate,
  });

  factory NewDonationRequestEvent.fromJson(Map<String, dynamic> json) {
    return NewDonationRequestEvent(
      requestId: json['requestId'] as String? ?? '',
      title: json['title'] as String? ?? '',
      body: json['body'] as String? ?? '',
      type: json['type'] as int? ?? 0,
      urgency: json['urgency'] as int? ?? 0,
      requiredBloodType: json['requiredBloodType'] as int? ?? 0,
      hospitalName: json['hospitalName'] as String? ?? '',
      expiryDate:
          DateTime.tryParse(json['expiryDate'] as String? ?? '') ??
          DateTime.now(),
    );
  }

  final String requestId;
  final String title;
  final String body;
  final int type;
  final int urgency;
  final int requiredBloodType;
  final String hospitalName;
  final DateTime expiryDate;

  @override
  List<Object?> get props => [
    requestId,
    title,
    body,
    type,
    urgency,
    requiredBloodType,
    hospitalName,
    expiryDate,
  ];
}

final class ActiveDonationUpdatedEvent extends RealtimeEvent {
  const ActiveDonationUpdatedEvent({
    required this.requestId,
    required this.acceptanceId,
    required this.status,
    required this.message,
  });

  factory ActiveDonationUpdatedEvent.fromJson(Map<String, dynamic> json) {
    return ActiveDonationUpdatedEvent(
      requestId: json['requestId'] as String? ?? '',
      acceptanceId: json['acceptanceId'] as String? ?? '',
      status: json['status'] as String? ?? '',
      message: json['message'] as String? ?? '',
    );
  }

  final String requestId;
  final String acceptanceId;
  final String status;
  final String message;

  @override
  List<Object?> get props => [requestId, acceptanceId, status, message];
}

final class RealtimeNotificationEvent extends RealtimeEvent {
  const RealtimeNotificationEvent({required this.title, required this.body});

  factory RealtimeNotificationEvent.fromJson(Map<String, dynamic> json) {
    return RealtimeNotificationEvent(
      title: json['title'] as String? ?? '',
      body: json['body'] as String? ?? '',
    );
  }

  final String title;
  final String body;

  @override
  List<Object?> get props => [title, body];
}

final class ProfileUpdatedEvent extends RealtimeEvent {
  const ProfileUpdatedEvent();
}

final class RealtimeReconnectedEvent extends RealtimeEvent {
  const RealtimeReconnectedEvent();
}
