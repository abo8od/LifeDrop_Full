// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'acceptance_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AcceptanceModel _$AcceptanceModelFromJson(Map<String, dynamic> json) =>
    AcceptanceModel(
      acceptanceId: json['acceptanceId'] as String,
      requestId: json['requestId'] as String,
      status: $enumDecode(_$DonationStatusEnumMap, json['status']),
    );

const _$DonationStatusEnumMap = {
  DonationStatus.Accepted: 'Accepted',
  DonationStatus.Fulfilled: 'Fulfilled',
  DonationStatus.CancelledByDonor: 'CancelledByDonor',
  DonationStatus.CancelledByHospital: 'CancelledByHospital',
  DonationStatus.NoShow: 'NoShow',
};
