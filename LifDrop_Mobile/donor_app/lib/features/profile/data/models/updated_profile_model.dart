import 'package:donor_app/features/profile/domain/entities/updated_profile_response_entity.dart';
import 'package:donor_app/core/enums/blood_type.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'updated_profile_model.g.dart';

@JsonSerializable(createToJson: false)
class UpdatedProfileResponseModel extends UpdatedProfileResponseEntity {
  const UpdatedProfileResponseModel({
    required super.isAvailable,
    required super.governorateId,
    required super.districtId,
    required super.receiveCriticalNotifications,
    required super.receiveUrgentNotifications,
    required super.receiveNormalNotifications,
    required super.firstName,
    required super.lastName,
    required super.phoneNumber,
    required super.bloodType,
  });

  factory UpdatedProfileResponseModel.fromJson(Map<String, dynamic> json) =>
      _$UpdatedProfileResponseModelFromJson(json);
}
