import 'package:donor_app/core/networking/api_result.dart';
import 'package:donor_app/core/networking/paged_response.dart';
import 'package:donor_app/features/donation_history/domain/entities/donation_history_entity.dart';
import 'package:donor_app/features/donation_history/domain/repositories/donation_history_repository.dart';
import 'package:donor_app/features/donation_history/presentation/logic/donation_history_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DonationHistoryCubit extends Cubit<DonationHistoryState> {
  DonationHistoryCubit(this._repository)
    : super(const DonationHistoryInitial());

  static const int _pageSize = 10;

  final DonationHistoryRepository _repository;

  Future<void> loadHistory() async {
    emit(const DonationHistoryLoading());

    final result = await _repository.getHistory(
      pageNumber: 1,
      pageSize: _pageSize,
    );

    result.when(
      success: (page) {
        if (page.data.isEmpty) {
          emit(const DonationHistoryEmpty());
          return;
        }
        emit(DonationHistorySuccess(page: page));
      },
      failure: (error) => emit(DonationHistoryError(error)),
    );
  }

  Future<void> loadMore() async {
    final currentState = state;
    if (currentState is! DonationHistorySuccess ||
        currentState.isLoadingMore ||
        !currentState.page.hasNextPage) {
      return;
    }

    emit(DonationHistorySuccess(page: currentState.page, isLoadingMore: true));

    final nextPage = currentState.page.pageNumber + 1;
    final result = await _repository.getHistory(
      pageNumber: nextPage,
      pageSize: _pageSize,
    );

    result.when(
      success: (page) => emit(
        DonationHistorySuccess(
          page: PagedResponse<DonationHistoryEntity>(
            data: [...currentState.page.data, ...page.data],
            pageNumber: page.pageNumber,
            pageSize: page.pageSize,
            totalCount: page.totalCount,
            totalPages: page.totalPages,
            hasPreviousPage: page.hasPreviousPage,
            hasNextPage: page.hasNextPage,
          ),
        ),
      ),
      failure: (_) => emit(DonationHistorySuccess(page: currentState.page)),
    );
  }
}
