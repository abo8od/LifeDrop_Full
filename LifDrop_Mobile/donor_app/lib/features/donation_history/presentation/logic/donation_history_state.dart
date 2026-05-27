import 'package:donor_app/core/networking/api_error_model.dart';
import 'package:donor_app/core/networking/paged_response.dart';
import 'package:donor_app/features/donation_history/domain/entities/donation_history_entity.dart';
import 'package:equatable/equatable.dart';

sealed class DonationHistoryState extends Equatable {
  const DonationHistoryState();

  @override
  List<Object?> get props => [];
}

class DonationHistoryInitial extends DonationHistoryState {
  const DonationHistoryInitial();
}

class DonationHistoryLoading extends DonationHistoryState {
  const DonationHistoryLoading();
}

class DonationHistorySuccess extends DonationHistoryState {
  const DonationHistorySuccess({
    required this.page,
    this.isLoadingMore = false,
  });

  final PagedResponse<DonationHistoryEntity> page;
  final bool isLoadingMore;

  @override
  List<Object?> get props => [page, isLoadingMore];
}

class DonationHistoryEmpty extends DonationHistoryState {
  const DonationHistoryEmpty();
}

class DonationHistoryError extends DonationHistoryState {
  const DonationHistoryError(this.error);

  final ApiErrorModel error;

  @override
  List<Object?> get props => [error];
}
