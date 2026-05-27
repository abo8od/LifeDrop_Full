import 'package:freezed_annotation/freezed_annotation.dart';
part 'register_params.g.dart';

@JsonSerializable()
class RegisterParams {
  final String firstName;
  final String lastName;
  final String email;
  final String phoneNumber;
  final String dateOfBirth;
  final String password;
  final String confirmPassword;
  final String governorateId;
  final String districtId;
  final String bloodType;

  const RegisterParams({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.phoneNumber,
    required this.dateOfBirth,
    required this.password,
    required this.confirmPassword,
    required this.governorateId,
    required this.districtId,
    required this.bloodType,
  });

  Map<String, dynamic> toJson() => _$RegisterParamsToJson(this);
}
