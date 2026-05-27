import 'package:donor_app/core/enums/donation_status.dart';
import 'package:donor_app/features/donation_request/domain/entities/acceptance_entity.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'acceptance_model.g.dart';

@JsonSerializable(createToJson: false)
class AcceptanceModel extends AcceptanceEntity {
  const AcceptanceModel({
    required super.acceptanceId,
    required super.requestId,
    required super.status,
  });

  factory AcceptanceModel.fromJson(Map<String, dynamic> json) =>
      _$AcceptanceModelFromJson(json);
}
