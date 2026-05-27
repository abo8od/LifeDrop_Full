// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cancel_acceptance_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CancelAcceptanceRequest _$CancelAcceptanceRequestFromJson(
  Map<String, dynamic> json,
) => CancelAcceptanceRequest(
  cancellationReasonId: json['cancellationReasonId'] as String,
  note: json['note'] as String,
);

Map<String, dynamic> _$CancelAcceptanceRequestToJson(
  CancelAcceptanceRequest instance,
) => <String, dynamic>{
  'cancellationReasonId': instance.cancellationReasonId,
  'note': instance.note,
};
