import 'package:donor_app/core/entities/governorate_entity.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
part 'governorate_model.g.dart';

@JsonSerializable(createToJson: false)
class GovernorateModel extends GovernorateEntity {
  GovernorateModel({required super.id, required super.name});

  factory GovernorateModel.fromJson(Map<String, dynamic> json) =>
      _$GovernorateModelFromJson(json);
}
