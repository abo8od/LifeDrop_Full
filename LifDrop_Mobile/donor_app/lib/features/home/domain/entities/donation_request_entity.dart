import 'package:donor_app/core/enums/blood_type.dart';
import 'package:donor_app/core/enums/urgency_status.dart';
import 'package:equatable/equatable.dart';

class DonationRequestEntity extends Equatable {
  final String requestId;
  final BloodType bloodType;
  final UrgencyStatus urgency;
  final String hospitalName;

  const DonationRequestEntity({
    required this.requestId,
    required this.bloodType,
    required this.urgency,
    required this.hospitalName,
  });

  bool get isCritical => urgency == UrgencyStatus.Critical;

  factory DonationRequestEntity.placeholder() => const DonationRequestEntity(
    requestId: 'placeholder',
    bloodType: BloodType.A_Negative,
    urgency: UrgencyStatus.Normal,
    hospitalName: 'placeholder',
  );

  @override
  List<Object?> get props => [requestId, bloodType, urgency, hospitalName];
}
