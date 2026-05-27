import 'package:donor_app/core/enums/blood_type.dart';
import 'package:donor_app/core/enums/donation_status.dart';
import 'package:donor_app/features/donation_history/domain/entities/donation_history_entity.dart';

/// Data model for a donor history item returned from the history endpoint.
class DonationHistoryModel extends DonationHistoryEntity {
  const DonationHistoryModel({
    required super.acceptanceId,
    required super.requestId,
    required super.hospitalName,
    required super.bloodType,
    required super.date,
    required super.status,
    required super.pointsEarned,
  });

  factory DonationHistoryModel.fromJson(Map<String, dynamic> json) {
    return DonationHistoryModel(
      acceptanceId: json['acceptanceId'] as String? ?? '',
      requestId: json['requestId'] as String? ?? '',
      hospitalName: json['hospitalName'] as String? ?? '',
      bloodType: _parseBloodType(json['bloodType'] as String?),
      date: DateTime.tryParse(json['date'] as String? ?? '') ?? DateTime(1970),
      status: _parseStatus(json['status'] as String?),
      pointsEarned: (json['pointsEarned'] as num?)?.toInt() ?? 0,
    );
  }

  static BloodType _parseBloodType(String? value) {
    return BloodType.values.firstWhere(
      (type) => type.name == value,
      orElse: () => BloodType.O_Positive,
    );
  }

  static DonationStatus _parseStatus(String? value) {
    return DonationStatus.values.firstWhere(
      (status) => status.name == value,
      orElse: () => DonationStatus.Accepted,
    );
  }
}
