import 'package:donor_app/core/networking/api_error_model.dart';
import 'package:donor_app/core/networking/paged_response.dart';
import 'package:donor_app/features/all_requests/domain/entities/donation_request_feed_entity.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'all_requests_state.freezed.dart';

@freezed
class AllRequestsState with _$AllRequestsState {
  const factory AllRequestsState.initial() = AllRequestsInitial;
  const factory AllRequestsState.loading() = AllRequestsLoading;
  const factory AllRequestsState.success({
    required PagedResponse<DonationRequestFeedEntity> page,
    required String searchTerm,
    required int? urgency,
    @Default(false) bool isLoadingMore,
  }) = AllRequestsSuccess;
  const factory AllRequestsState.empty({
    required String searchTerm,
    required int? urgency,
  }) = AllRequestsEmpty;
  const factory AllRequestsState.error(ApiErrorModel error) = AllRequestsError;
}
