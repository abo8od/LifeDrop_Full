import 'package:freezed_annotation/freezed_annotation.dart';
part 'account.g.dart';

@JsonSerializable()
class Account {
  final String email;
  final String password;

  Account({required this.email, required this.password});

  factory Account.fromJson(Map<String, dynamic> json) =>
      _$AccountFromJson(json);
  Map<String, dynamic> toJson() => _$AccountToJson(this);
}
