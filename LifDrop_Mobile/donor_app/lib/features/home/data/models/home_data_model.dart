import 'package:donor_app/features/home/domain/entities/home_data_entity.dart';
import 'package:donor_app/features/home/data/models/donation_request_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'home_data_model.g.dart';

@JsonSerializable(createToJson: false)
class HomeDataModel extends HomeDataEntity {
  @override
  final List<DonationRequestModel> activeRequests;

  @override
  const HomeDataModel({
    required super.username,
    @JsonKey(defaultValue: '') required super.lastHospitalName,
    required super.remainingDays,
    required super.totalContributions,
    required this.activeRequests,
  }) : super(activeRequests: activeRequests);

  factory HomeDataModel.fromJson(Map<String, dynamic> json) =>
      _$HomeDataModelFromJson(json);
}
