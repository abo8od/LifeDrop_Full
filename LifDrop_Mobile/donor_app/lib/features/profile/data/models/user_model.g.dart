// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserModel _$UserModelFromJson(Map<String, dynamic> json) => UserModel(
  userId: json['userId'] as String,
  firstName: json['firstName'] as String,
  lastName: json['lastName'] as String,
  email: json['email'] as String,
  phoneNumber: json['phoneNumber'] as String,
  bloodType: $enumDecode(_$BloodTypeEnumMap, json['bloodType']),
  isMedicallyVerified: json['isMedicallyVerified'] as bool,
  isAvailable: json['isAvailable'] as bool,
  governorateName: json['governorateName'] as String,
  districtName: json['districtName'] as String,
  reliabilityScore: (json['reliabilityScore'] as num).toInt(),
  gamificationPoints: (json['gamificationPoints'] as num).toInt(),
  isEligibleToDonate: json['isEligibleToDonate'] as bool,
  totalDonations: (json['totalDonations'] as num).toInt(),
  receiveCriticalNotifications: json['receiveCriticalNotifications'] as bool,
  receiveUrgentNotifications: json['receiveUrgentNotifications'] as bool,
  receiveNormalNotifications: json['receiveNormalNotifications'] as bool,
);

const _$BloodTypeEnumMap = {
  BloodType.O_Positive: 'O_Positive',
  BloodType.O_Negative: 'O_Negative',
  BloodType.A_Positive: 'A_Positive',
  BloodType.A_Negative: 'A_Negative',
  BloodType.B_Positive: 'B_Positive',
  BloodType.B_Negative: 'B_Negative',
  BloodType.AB_Positive: 'AB_Positive',
  BloodType.AB_Negative: 'AB_Negative',
};
