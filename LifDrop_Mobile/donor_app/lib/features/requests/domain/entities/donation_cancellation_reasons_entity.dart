import 'package:equatable/equatable.dart';

class DonationCancellationReasonsEntity extends Equatable {
  final String id;
  final String displayName;
  final String displayNameAr;
  final String displayNameEn;

  const DonationCancellationReasonsEntity({
    required this.id,
    required this.displayName,
    required this.displayNameAr,
    required this.displayNameEn,
  });

  @override
  List<Object?> get props => [id, displayName, displayNameAr, displayNameEn];
}
