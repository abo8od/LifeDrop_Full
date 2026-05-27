// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'update_profile_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UpdateProfileRequest _$UpdateProfileRequestFromJson(
  Map<String, dynamic> json,
) => UpdateProfileRequest(
  firstName: json['firstName'] as String,
  lastName: json['lastName'] as String,
  phoneNumber: json['phoneNumber'] as String,
  bloodType: $enumDecodeNullable(_$BloodTypeEnumMap, json['bloodType']),
  isAvailable: json['isAvailable'] as bool?,
  governorateId: json['governorateId'] as String,
  districtId: json['districtId'] as String,
  receiveCriticalNotifications: json['receiveCriticalNotifications'] as bool?,
  receiveUrgentNotifications: json['receiveUrgentNotifications'] as bool,
  receiveNormalNotifications: json['receiveNormalNotifications'] as bool,
);

Map<String, dynamic> _$UpdateProfileRequestToJson(
  UpdateProfileRequest instance,
) => <String, dynamic>{
  'firstName': instance.firstName,
  'lastName': instance.lastName,
  'phoneNumber': instance.phoneNumber,
  'bloodType': _$BloodTypeEnumMap[instance.bloodType],
  'isAvailable': instance.isAvailable,
  'governorateId': instance.governorateId,
  'districtId': instance.districtId,
  'receiveCriticalNotifications': instance.receiveCriticalNotifications,
  'receiveUrgentNotifications': instance.receiveUrgentNotifications,
  'receiveNormalNotifications': instance.receiveNormalNotifications,
};

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
