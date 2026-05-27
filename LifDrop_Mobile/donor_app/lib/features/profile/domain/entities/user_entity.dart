import 'package:donor_app/core/enums/blood_type.dart';
import 'package:equatable/equatable.dart';

class UserEntity extends Equatable {
  final String userId;
  final String firstName;
  final String lastName;
  final String email;
  final String phoneNumber;
  final BloodType bloodType;
  final bool isMedicallyVerified;
  final bool isAvailable;
  final String governorateName;
  final String districtName;
  final int reliabilityScore;
  final int gamificationPoints;
  final bool isEligibleToDonate;
  final int totalDonations;
  final bool receiveCriticalNotifications;
  final bool receiveUrgentNotifications;
  final bool receiveNormalNotifications;

  const UserEntity({
    required this.userId,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.phoneNumber,
    required this.bloodType,
    required this.isMedicallyVerified,
    required this.isAvailable,
    required this.governorateName,
    required this.districtName,
    required this.reliabilityScore,
    required this.gamificationPoints,
    required this.isEligibleToDonate,
    required this.totalDonations,
    required this.receiveCriticalNotifications,
    required this.receiveUrgentNotifications,
    required this.receiveNormalNotifications,
  });

  @override
  List<Object?> get props => [
    userId,
    firstName,
    lastName,
    email,
    phoneNumber,
    bloodType,
    isMedicallyVerified,
    isAvailable,
    governorateName,
    districtName,
    reliabilityScore,
    gamificationPoints,
    isEligibleToDonate,
    totalDonations,
    receiveCriticalNotifications,
    receiveUrgentNotifications,
    receiveNormalNotifications,
  ];
}
