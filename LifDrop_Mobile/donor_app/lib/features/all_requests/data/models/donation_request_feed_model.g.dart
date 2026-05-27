// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'donation_request_feed_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_DonationRequestFeedModel _$DonationRequestFeedModelFromJson(
  Map<String, dynamic> json,
) => _DonationRequestFeedModel(
  requestId: json['requestId'] as String,
  hospitalName: json['hospitalName'] as String,
  governorateName: json['governorateName'] as String,
  requiredBloodType: $enumDecode(_$BloodTypeEnumMap, json['requiredBloodType']),
  targetQuota: (json['targetQuota'] as num).toInt(),
  remainingQuota: (json['remainingQuota'] as num).toInt(),
  urgency: $enumDecode(_$UrgencyStatusEnumMap, json['urgency']),
  expiryDate: DateTime.parse(json['expiryDate'] as String),
  distancePriority: (json['distancePriority'] as num).toInt(),
  hospitalLatitude: (json['hospitalLatitude'] as num).toDouble(),
  hospitalLongitude: (json['hospitalLongitude'] as num).toDouble(),
);

Map<String, dynamic> _$DonationRequestFeedModelToJson(
  _DonationRequestFeedModel instance,
) => <String, dynamic>{
  'requestId': instance.requestId,
  'hospitalName': instance.hospitalName,
  'governorateName': instance.governorateName,
  'requiredBloodType': _$BloodTypeEnumMap[instance.requiredBloodType]!,
  'targetQuota': instance.targetQuota,
  'remainingQuota': instance.remainingQuota,
  'urgency': _$UrgencyStatusEnumMap[instance.urgency]!,
  'expiryDate': instance.expiryDate.toIso8601String(),
  'distancePriority': instance.distancePriority,
  'hospitalLatitude': instance.hospitalLatitude,
  'hospitalLongitude': instance.hospitalLongitude,
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

const _$UrgencyStatusEnumMap = {
  UrgencyStatus.Normal: 'Normal',
  UrgencyStatus.Urgent: 'Urgent',
  UrgencyStatus.Critical: 'Critical',
};
