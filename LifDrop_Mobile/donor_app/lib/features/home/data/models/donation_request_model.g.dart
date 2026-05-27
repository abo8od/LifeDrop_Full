// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'donation_request_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DonationRequestModel _$DonationRequestModelFromJson(
  Map<String, dynamic> json,
) => DonationRequestModel(
  requestId: json['requestId'] as String,
  bloodType: $enumDecode(_$BloodTypeEnumMap, json['bloodType']),
  urgency: $enumDecode(_$UrgencyStatusEnumMap, json['urgency']),
  hospitalName: json['hospitalName'] as String,
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

const _$UrgencyStatusEnumMap = {
  UrgencyStatus.Normal: 'Normal',
  UrgencyStatus.Urgent: 'Urgent',
  UrgencyStatus.Critical: 'Critical',
};
