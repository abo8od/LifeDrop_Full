import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:donor_app/core/networking/api_error_model.dart';
import 'package:donor_app/features/requests/domain/entities/donation_cancellation_reasons_entity.dart';

part 'cancellation_reasons_state.freezed.dart';

enum CancellationReasonsStatus { initial, loading, success, failure }

@freezed
class CancellationReasonsState with _$CancellationReasonsState {
  @override
  final CancellationReasonsStatus status;
  @override
  final List<DonationCancellationReasonsEntity> reasons;
  @override
  final ApiErrorModel? error;

  CancellationReasonsState({
    this.status = CancellationReasonsStatus.initial,
    this.reasons = const [],
    this.error,
  });
}
