import 'package:donor_app/core/enums/blood_type.dart';
import 'package:donor_app/core/enums/donation_status.dart';
import 'package:donor_app/core/enums/request_status.dart';
import 'package:donor_app/core/enums/urgency_status.dart';
import 'package:equatable/equatable.dart';

/// Full donation request details shown before a donor accepts a request.
class RequestDetailsEntity extends Equatable {
  final String requestId;
  final String hospitalName;
  final String hospitalAddress;
  final double hospitalLatitude;
  final double hospitalLongitude;
  final String hospitalPhoneNumber;
  final BloodType requiredBloodType;
  final UrgencyStatus urgency;
  final RequestStatus status;
  final DateTime expiryDate;
  final bool isAcceptedByCurrentUser;
  final DonationStatus? currentUserAcceptanceStatus;
  final DateTime? acceptedAt;

  const RequestDetailsEntity({
    required this.requestId,
    required this.hospitalName,
    required this.hospitalAddress,
    required this.hospitalLatitude,
    required this.hospitalLongitude,
    required this.hospitalPhoneNumber,
    required this.requiredBloodType,
    required this.urgency,
    required this.status,
    required this.expiryDate,
    required this.isAcceptedByCurrentUser,
    required this.currentUserAcceptanceStatus,
    required this.acceptedAt,
  });

  bool get canAccept =>
      status == RequestStatus.Active && !isAcceptedByCurrentUser;

  bool get isCritical => urgency == UrgencyStatus.Critical;

  factory RequestDetailsEntity.placeholder() => RequestDetailsEntity(
    requestId: 'placeholder',
    hospitalName: 'Hospital Name Here',
    hospitalAddress: 'Hospital Address Here',
    hospitalLatitude: 0,
    hospitalLongitude: 0,
    hospitalPhoneNumber: '',
    requiredBloodType: BloodType.AB_Negative,
    urgency: UrgencyStatus.Critical,
    status: RequestStatus.Active,
    expiryDate: DateTime.now(),
    isAcceptedByCurrentUser: false,
    currentUserAcceptanceStatus: null,
    acceptedAt: null,
  );

  @override
  List<Object?> get props => [
    requestId,
    hospitalName,
    hospitalAddress,
    hospitalLatitude,
    hospitalLongitude,
    hospitalPhoneNumber,
    requiredBloodType,
    urgency,
    status,
    expiryDate,
    isAcceptedByCurrentUser,
    currentUserAcceptanceStatus,
    acceptedAt,
  ];
}
