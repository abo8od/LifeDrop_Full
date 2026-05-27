import 'package:freezed_annotation/freezed_annotation.dart';
part 'api_response.g.dart';

@JsonSerializable(createToJson: false, genericArgumentFactories: true)
class ApiResponse<T> {
  final int code;
  final String message;
  final T data;

  ApiResponse({required this.code, required this.message, required this.data});

  factory ApiResponse.fromJson(
    Map<String, dynamic> json,
    T Function(Object? json) fromJsonT,
  ) => _$ApiResponseFromJson(json, fromJsonT);
}
