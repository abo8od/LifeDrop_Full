// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cooldown_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CooldownModel _$CooldownModelFromJson(Map<String, dynamic> json) =>
    CooldownModel(
      nextEligibleDate: DateTime.parse(json['nextEligibleDate'] as String),
      daysRemaining: (json['daysRemaining'] as num).toInt(),
      isEligible: json['isEligible'] as bool,
    );
