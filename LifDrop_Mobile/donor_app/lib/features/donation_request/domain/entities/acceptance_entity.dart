import 'package:donor_app/core/enums/donation_status.dart';
import 'package:equatable/equatable.dart';

/// Donation request acceptance result returned after accepting a request.
class AcceptanceEntity extends Equatable {
  final String acceptanceId;
  final String requestId;
  final DonationStatus status;

  const AcceptanceEntity({
    required this.acceptanceId,
    required this.requestId,
    required this.status,
  });

  @override
  List<Object?> get props => [acceptanceId, requestId, status];
}
