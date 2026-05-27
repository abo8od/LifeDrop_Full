// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'register_params.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RegisterParams _$RegisterParamsFromJson(Map<String, dynamic> json) =>
    RegisterParams(
      firstName: json['firstName'] as String,
      lastName: json['lastName'] as String,
      email: json['email'] as String,
      phoneNumber: json['phoneNumber'] as String,
      dateOfBirth: json['dateOfBirth'] as String,
      password: json['password'] as String,
      confirmPassword: json['confirmPassword'] as String,
      governorateId: json['governorateId'] as String,
      districtId: json['districtId'] as String,
      bloodType: json['bloodType'] as String,
    );

Map<String, dynamic> _$RegisterParamsToJson(RegisterParams instance) =>
    <String, dynamic>{
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'email': instance.email,
      'phoneNumber': instance.phoneNumber,
      'dateOfBirth': instance.dateOfBirth,
      'password': instance.password,
      'confirmPassword': instance.confirmPassword,
      'governorateId': instance.governorateId,
      'districtId': instance.districtId,
      'bloodType': instance.bloodType,
    };
