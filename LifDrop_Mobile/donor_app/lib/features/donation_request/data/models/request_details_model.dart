import 'package:donor_app/core/enums/blood_type.dart';
import 'package:donor_app/core/enums/donation_status.dart';
import 'package:donor_app/core/enums/request_status.dart';
import 'package:donor_app/core/enums/urgency_status.dart';
import 'package:donor_app/features/donation_request/domain/entities/request_details_entity.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'request_details_model.g.dart';

@JsonSerializable(createToJson: false)
class RequestDetailsModel extends RequestDetailsEntity {
  const RequestDetailsModel({
    required super.requestId,
    required super.hospitalName,
    required super.hospitalAddress,
    required super.hospitalLatitude,
    required super.hospitalLongitude,
    required super.hospitalPhoneNumber,
    required super.requiredBloodType,
    required super.urgency,
    required super.status,
    required super.expiryDate,
    required super.isAcceptedByCurrentUser,
    required super.currentUserAcceptanceStatus,
    required super.acceptedAt,
  });

  factory RequestDetailsModel.fromJson(Map<String, dynamic> json) =>
      _$RequestDetailsModelFromJson(json);
}
