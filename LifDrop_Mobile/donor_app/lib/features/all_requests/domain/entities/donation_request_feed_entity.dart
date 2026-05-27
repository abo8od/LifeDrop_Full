import 'package:donor_app/core/enums/blood_type.dart';
import 'package:donor_app/core/enums/urgency_status.dart';
import 'package:equatable/equatable.dart';

/// Donation request item shown in the all requests feed.
class DonationRequestFeedEntity extends Equatable {
  const DonationRequestFeedEntity({
    required this.requestId,
    required this.hospitalName,
    required this.governorateName,
    required this.requiredBloodType,
    required this.targetQuota,
    required this.remainingQuota,
    required this.urgency,
    required this.expiryDate,
    required this.distancePriority,
    required this.hospitalLatitude,
    required this.hospitalLongitude,
  });

  final String requestId;
  final String hospitalName;
  final String governorateName;
  final BloodType requiredBloodType;
  final int targetQuota;
  final int remainingQuota;
  final UrgencyStatus urgency;
  final DateTime expiryDate;
  final int distancePriority;
  final double hospitalLatitude;
  final double hospitalLongitude;

  bool get isCritical => urgency == UrgencyStatus.Critical;

  @override
  List<Object?> get props => [
    requestId,
    hospitalName,
    governorateName,
    requiredBloodType,
    targetQuota,
    remainingQuota,
    urgency,
    expiryDate,
    distancePriority,
    hospitalLatitude,
    hospitalLongitude,
  ];
}
