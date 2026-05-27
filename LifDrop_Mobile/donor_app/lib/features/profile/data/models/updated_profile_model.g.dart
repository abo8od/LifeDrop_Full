// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'updated_profile_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UpdatedProfileResponseModel _$UpdatedProfileResponseModelFromJson(
  Map<String, dynamic> json,
) => UpdatedProfileResponseModel(
  isAvailable: json['isAvailable'] as bool,
  governorateId: json['governorateId'] as String,
  districtId: json['districtId'] as String,
  receiveCriticalNotifications: json['receiveCriticalNotifications'] as bool,
  receiveUrgentNotifications: json['receiveUrgentNotifications'] as bool,
  receiveNormalNotifications: json['receiveNormalNotifications'] as bool,
  firstName: json['firstName'] as String,
  lastName: json['lastName'] as String,
  phoneNumber: json['phoneNumber'] as String,
  bloodType: $enumDecode(_$BloodTypeEnumMap, json['bloodType']),
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
