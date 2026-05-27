import 'package:donor_app/core/enums/blood_type.dart';
import 'package:donor_app/core/enums/donation_status.dart';
import 'package:donor_app/core/enums/urgency_status.dart';
import 'package:equatable/equatable.dart';

class ActiveDonationEntity extends Equatable {
  final String acceptanceId;
  final String requestId;
  final String hospitalName;
  final String hospitalAddress;
  final String hospitalPhoneNumber;
  final double hospitalLatitude;
  final double hospitalLongitude;
  final BloodType requiredBloodType;
  final UrgencyStatus urgency;
  final int unitsRequested;
  final DonationStatus status;
  final DateTime acceptedAt;
  final int remainingMinutes;

  const ActiveDonationEntity({
    required this.acceptanceId,
    required this.requestId,
    required this.hospitalName,
    required this.hospitalAddress,
    required this.hospitalPhoneNumber,
    required this.hospitalLatitude,
    required this.hospitalLongitude,
    required this.requiredBloodType,
    required this.urgency,
    required this.unitsRequested,
    required this.status,
    required this.acceptedAt,
    required this.remainingMinutes,
  });

  factory ActiveDonationEntity.placeholder() => ActiveDonationEntity(
    acceptanceId: 'placeholder',
    requestId: 'placeholder',
    hospitalName: 'Hospital Name Here',
    hospitalAddress: 'Hospital Address Here',
    hospitalPhoneNumber: '0780000000',
    hospitalLatitude: 0.0,
    hospitalLongitude: 0.0,
    requiredBloodType: BloodType.A_Negative,
    urgency: UrgencyStatus.Normal,
    unitsRequested: 1,
    status: DonationStatus.NoShow,
    acceptedAt: DateTime.now(),
    remainingMinutes: 0,
  );

  ActiveDonationEntity copyWithStatus(DonationStatus status) {
    return ActiveDonationEntity(
      acceptanceId: acceptanceId,
      requestId: requestId,
      hospitalName: hospitalName,
      hospitalAddress: hospitalAddress,
      hospitalPhoneNumber: hospitalPhoneNumber,
      hospitalLatitude: hospitalLatitude,
      hospitalLongitude: hospitalLongitude,
      requiredBloodType: requiredBloodType,
      urgency: urgency,
      unitsRequested: unitsRequested,
      status: status,
      acceptedAt: acceptedAt,
      remainingMinutes: remainingMinutes,
    );
  }

  @override
  List<Object?> get props => [
    acceptanceId,
    requestId,
    hospitalName,
    hospitalAddress,
    hospitalPhoneNumber,
    hospitalLatitude,
    hospitalLongitude,
    requiredBloodType,
    urgency,
    unitsRequested,
    status,
    acceptedAt,
    remainingMinutes,
  ];
}
