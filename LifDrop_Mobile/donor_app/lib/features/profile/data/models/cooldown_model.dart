import 'package:donor_app/features/profile/domain/entities/cooldown_entity.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'cooldown_model.g.dart';

@JsonSerializable(createToJson: false)
class CooldownModel extends CooldownEntity {
  const CooldownModel({
    required super.nextEligibleDate,
    required super.daysRemaining,
    required super.isEligible,
  });

  factory CooldownModel.fromJson(Map<String, dynamic> json) =>
      _$CooldownModelFromJson(json);
}
