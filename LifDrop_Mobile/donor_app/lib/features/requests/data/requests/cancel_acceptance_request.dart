import 'package:json_annotation/json_annotation.dart';

part 'cancel_acceptance_request.g.dart';

@JsonSerializable()
class CancelAcceptanceRequest {
  final String cancellationReasonId;
  final String note;

  CancelAcceptanceRequest({
    required this.cancellationReasonId,
    required this.note,
  });

  Map<String, dynamic> toJson() => _$CancelAcceptanceRequestToJson(this);
}
