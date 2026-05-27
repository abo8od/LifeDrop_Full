import 'package:donor_app/features/requests/domain/entities/active_donation_entity.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:donor_app/core/enums/blood_type.dart';
import 'package:donor_app/core/enums/donation_status.dart';
import 'package:donor_app/core/enums/urgency_status.dart';

part 'active_donation_model.g.dart';

@JsonSerializable(createToJson: false)
class ActiveDonationModel extends ActiveDonationEntity {
  const ActiveDonationModel({
    required super.acceptanceId,
    required super.requestId,
    required super.hospitalName,
    required super.hospitalAddress,
    required super.hospitalPhoneNumber,
    required super.hospitalLatitude,
    required super.hospitalLongitude,
    required super.requiredBloodType,
    required super.urgency,
    required super.unitsRequested,
    required super.status,
    required super.acceptedAt,
    required super.remainingMinutes,
  });

  factory ActiveDonationModel.fromJson(Map<String, dynamic> json) =>
      _$ActiveDonationModelFromJson(json);
}
