import 'package:donor_app/core/networking/api_result.dart';
import 'package:donor_app/core/networking/paged_response.dart';
import 'package:donor_app/features/all_requests/domain/entities/donation_request_feed_entity.dart';
import 'package:donor_app/features/all_requests/domain/repositories/all_requests_repository.dart';
import 'package:donor_app/features/all_requests/presentation/logic/all_requests_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AllRequestsCubit extends Cubit<AllRequestsState> {
  AllRequestsCubit(this._repository) : super(const AllRequestsState.initial());

  static const int _pageSize = 10;

  final AllRequestsRepository _repository;

  Future<void> loadRequests({String searchTerm = '', int? urgency}) async {
    emit(const AllRequestsState.loading());

    final result = await _repository.getRequests(
      pageNumber: 1,
      pageSize: _pageSize,
      searchTerm: searchTerm,
      urgency: urgency,
    );

    result.when(
      success: (page) {
        if (page.data.isEmpty) {
          emit(
            AllRequestsState.empty(searchTerm: searchTerm, urgency: urgency),
          );
          return;
        }
        emit(
          AllRequestsState.success(
            page: page,
            searchTerm: searchTerm,
            urgency: urgency,
          ),
        );
      },
      failure: (error) => emit(AllRequestsState.error(error)),
    );
  }

  Future<void> loadMore() async {
    final currentState = state;
    if (currentState is! AllRequestsSuccess ||
        currentState.isLoadingMore ||
        !currentState.page.hasNextPage) {
      return;
    }

    emit(currentState.copyWith(isLoadingMore: true));

    final result = await _repository.getRequests(
      pageNumber: currentState.page.pageNumber + 1,
      pageSize: _pageSize,
      searchTerm: currentState.searchTerm,
      urgency: currentState.urgency,
    );

    result.when(
      success: (page) => emit(
        AllRequestsState.success(
          page: PagedResponse<DonationRequestFeedEntity>(
            data: [...currentState.page.data, ...page.data],
            pageNumber: page.pageNumber,
            pageSize: page.pageSize,
            totalCount: page.totalCount,
            totalPages: page.totalPages,
            hasPreviousPage: page.hasPreviousPage,
            hasNextPage: page.hasNextPage,
          ),
          searchTerm: currentState.searchTerm,
          urgency: currentState.urgency,
        ),
      ),
      failure: (_) => emit(currentState.copyWith(isLoadingMore: false)),
    );
  }
}
