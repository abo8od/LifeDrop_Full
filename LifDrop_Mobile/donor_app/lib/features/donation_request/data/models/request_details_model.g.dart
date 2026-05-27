// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'request_details_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RequestDetailsModel _$RequestDetailsModelFromJson(Map<String, dynamic> json) =>
    RequestDetailsModel(
      requestId: json['requestId'] as String,
      hospitalName: json['hospitalName'] as String,
      hospitalAddress: json['hospitalAddress'] as String,
      hospitalLatitude: (json['hospitalLatitude'] as num).toDouble(),
      hospitalLongitude: (json['hospitalLongitude'] as num).toDouble(),
      hospitalPhoneNumber: json['hospitalPhoneNumber'] as String,
      requiredBloodType: $enumDecode(
        _$BloodTypeEnumMap,
        json['requiredBloodType'],
      ),
      urgency: $enumDecode(_$UrgencyStatusEnumMap, json['urgency']),
      status: $enumDecode(_$RequestStatusEnumMap, json['status']),
      expiryDate: DateTime.parse(json['expiryDate'] as String),
      isAcceptedByCurrentUser: json['isAcceptedByCurrentUser'] as bool,
      currentUserAcceptanceStatus: $enumDecodeNullable(
        _$DonationStatusEnumMap,
        json['currentUserAcceptanceStatus'],
      ),
      acceptedAt: json['acceptedAt'] == null
          ? null
          : DateTime.parse(json['acceptedAt'] as String),
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

const _$RequestStatusEnumMap = {
  RequestStatus.Active: 'Active',
  RequestStatus.Fulfilled: 'Fulfilled',
  RequestStatus.Cancelled: 'Cancelled',
  RequestStatus.Expired: 'Expired',
};

const _$DonationStatusEnumMap = {
  DonationStatus.Accepted: 'Accepted',
  DonationStatus.Fulfilled: 'Fulfilled',
  DonationStatus.CancelledByDonor: 'CancelledByDonor',
  DonationStatus.CancelledByHospital: 'CancelledByHospital',
  DonationStatus.NoShow: 'NoShow',
};
