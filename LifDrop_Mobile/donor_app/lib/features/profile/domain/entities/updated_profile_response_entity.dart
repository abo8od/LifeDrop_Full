import 'package:donor_app/core/enums/blood_type.dart';
import 'package:equatable/equatable.dart';

class UpdatedProfileResponseEntity extends Equatable {
  final String firstName;
  final String lastName;
  final String phoneNumber;
  final BloodType bloodType;
  final bool isAvailable;
  final String governorateId;
  final String districtId;
  final bool receiveCriticalNotifications;
  final bool receiveUrgentNotifications;
  final bool receiveNormalNotifications;

  const UpdatedProfileResponseEntity({
    required this.firstName,
    required this.lastName,
    required this.phoneNumber,
    required this.bloodType,
    required this.isAvailable,
    required this.governorateId,
    required this.districtId,
    required this.receiveCriticalNotifications,
    required this.receiveUrgentNotifications,
    required this.receiveNormalNotifications,
  });

  @override
  List<Object?> get props => [
    firstName,
    lastName,
    phoneNumber,
    bloodType,
    isAvailable,
    governorateId,
    districtId,
    receiveCriticalNotifications,
    receiveUrgentNotifications,
    receiveNormalNotifications,
  ];
}
