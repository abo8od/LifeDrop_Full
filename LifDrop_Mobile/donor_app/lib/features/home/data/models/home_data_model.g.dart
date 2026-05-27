// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_data_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HomeDataModel _$HomeDataModelFromJson(Map<String, dynamic> json) =>
    HomeDataModel(
      username: json['username'] as String,
      lastHospitalName: json['lastHospitalName'] as String? ?? '',
      remainingDays: (json['remainingDays'] as num).toInt(),
      totalContributions: (json['totalContributions'] as num).toInt(),
      activeRequests: (json['activeRequests'] as List<dynamic>)
          .map((e) => DonationRequestModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
