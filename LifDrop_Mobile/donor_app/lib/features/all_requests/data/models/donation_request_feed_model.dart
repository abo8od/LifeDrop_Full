import 'package:donor_app/core/enums/blood_type.dart';
import 'package:donor_app/core/enums/urgency_status.dart';
import 'package:donor_app/features/all_requests/domain/entities/donation_request_feed_entity.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'donation_request_feed_model.freezed.dart';
part 'donation_request_feed_model.g.dart';

@freezed
abstract class DonationRequestFeedModel
    with _$DonationRequestFeedModel
    implements DonationRequestFeedEntity {
  const DonationRequestFeedModel._();

  const factory DonationRequestFeedModel({
    required String requestId,
    required String hospitalName,
    required String governorateName,
    required BloodType requiredBloodType,
    required int targetQuota,
    required int remainingQuota,
    required UrgencyStatus urgency,
    required DateTime expiryDate,
    required int distancePriority,
    required double hospitalLatitude,
    required double hospitalLongitude,
  }) = _DonationRequestFeedModel;

  factory DonationRequestFeedModel.fromJson(Map<String, dynamic> json) =>
      _$DonationRequestFeedModelFromJson(json);

  @override
  bool get isCritical => urgency == UrgencyStatus.Critical;

  @override
  List<Object?> get props => [
    requestId,
    hospitalName,
    governorateName,
    requiredBloodType,
    targetQuota,
    remainingQuota,
    urgency,
    expiryDate,
    distancePriority,
    hospitalLatitude,
    hospitalLongitude,
  ];

  @override
  bool? get stringify => true;
}
