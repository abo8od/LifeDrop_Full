import 'package:donor_app/features/profile/domain/entities/user_entity.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:donor_app/core/enums/blood_type.dart';

part 'user_model.g.dart';

@JsonSerializable(createToJson: false)
class UserModel extends UserEntity {
  const UserModel({
    required super.userId,
    required super.firstName,
    required super.lastName,
    required super.email,
    required super.phoneNumber,
    required super.bloodType,
    required super.isMedicallyVerified,
    required super.isAvailable,
    required super.governorateName,
    required super.districtName,
    required super.reliabilityScore,
    required super.gamificationPoints,
    required super.isEligibleToDonate,
    required super.totalDonations,
    required super.receiveCriticalNotifications,
    required super.receiveUrgentNotifications,
    required super.receiveNormalNotifications,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);
}
