import 'package:donor_app/features/requests/domain/entities/donation_cancellation_reasons_entity.dart';
import 'package:json_annotation/json_annotation.dart';
part 'donation_cancellation_reasons_model.g.dart';

@JsonSerializable(createToJson: false)
class DonationCancellationReasonsModel
    extends DonationCancellationReasonsEntity {
  const DonationCancellationReasonsModel({
    required super.id,
    required super.displayName,
    required super.displayNameAr,
    required super.displayNameEn,
  });

  factory DonationCancellationReasonsModel.fromJson(
    Map<String, dynamic> json,
  ) => _$DonationCancellationReasonsModelFromJson(json);
}
