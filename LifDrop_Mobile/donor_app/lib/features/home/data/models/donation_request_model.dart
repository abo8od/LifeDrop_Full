import 'package:donor_app/features/home/domain/entities/donation_request_entity.dart';
import 'package:donor_app/core/enums/blood_type.dart';
import 'package:donor_app/core/enums/urgency_status.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'donation_request_model.g.dart';

@JsonSerializable(createToJson: false)
class DonationRequestModel extends DonationRequestEntity {
  const DonationRequestModel({
    required super.requestId,
    required super.bloodType,
    required super.urgency,
    required super.hospitalName,
  });

  factory DonationRequestModel.fromJson(Map<String, dynamic> json) =>
      _$DonationRequestModelFromJson(json);
}
