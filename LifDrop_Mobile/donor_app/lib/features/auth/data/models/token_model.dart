import 'package:json_annotation/json_annotation.dart';
import '../../domain/entities/token_entity.dart';

part 'token_model.g.dart';

@JsonSerializable(createToJson: false)
class TokenModel extends TokenEntity {
  const TokenModel({required super.accessToken, required super.refreshToken});

  factory TokenModel.fromJson(Map<String, dynamic> json) =>
      _$TokenModelFromJson(json);
}
