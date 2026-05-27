// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'active_donation_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ActiveDonationModel _$ActiveDonationModelFromJson(Map<String, dynamic> json) =>
    ActiveDonationModel(
      acceptanceId: json['acceptanceId'] as String,
      requestId: json['requestId'] as String,
      hospitalName: json['hospitalName'] as String,
      hospitalAddress: json['hospitalAddress'] as String,
      hospitalPhoneNumber: json['hospitalPhoneNumber'] as String,
      hospitalLatitude: (json['hospitalLatitude'] as num).toDouble(),
      hospitalLongitude: (json['hospitalLongitude'] as num).toDouble(),
      requiredBloodType: $enumDecode(
        _$BloodTypeEnumMap,
        json['requiredBloodType'],
      ),
      urgency: $enumDecode(_$UrgencyStatusEnumMap, json['urgency']),
      unitsRequested: (json['unitsRequested'] as num).toInt(),
      status: $enumDecode(_$DonationStatusEnumMap, json['status']),
      acceptedAt: DateTime.parse(json['acceptedAt'] as String),
      remainingMinutes: (json['remainingMinutes'] as num).toInt(),
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

const _$DonationStatusEnumMap = {
  DonationStatus.Accepted: 'Accepted',
  DonationStatus.Fulfilled: 'Fulfilled',
  DonationStatus.CancelledByDonor: 'CancelledByDonor',
  DonationStatus.CancelledByHospital: 'CancelledByHospital',
  DonationStatus.NoShow: 'NoShow',
};
