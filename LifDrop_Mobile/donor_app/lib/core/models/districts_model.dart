import 'package:donor_app/core/entities/districts_entity.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
part 'districts_model.g.dart';

@JsonSerializable(createToJson: false)
class DistrictsModel extends DistrictsEntity {
  DistrictsModel({required super.id, required super.name});

  factory DistrictsModel.fromJson(Map<String, dynamic> json) =>
      _$DistrictsModelFromJson(json);
}
