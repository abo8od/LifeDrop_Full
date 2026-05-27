import 'package:donor_app/core/enums/blood_type.dart';
import 'package:donor_app/core/enums/donation_status.dart';
import 'package:equatable/equatable.dart';

/// Donation history record shown in the donor timeline.
class DonationHistoryEntity extends Equatable {
  const DonationHistoryEntity({
    required this.acceptanceId,
    required this.requestId,
    required this.hospitalName,
    required this.bloodType,
    required this.date,
    required this.status,
    required this.pointsEarned,
  });

  final String acceptanceId;
  final String requestId;
  final String hospitalName;
  final BloodType bloodType;
  final DateTime date;
  final DonationStatus status;
  final int pointsEarned;

  @override
  List<Object?> get props => [
    acceptanceId,
    requestId,
    hospitalName,
    bloodType,
    date,
    status,
    pointsEarned,
  ];
}
