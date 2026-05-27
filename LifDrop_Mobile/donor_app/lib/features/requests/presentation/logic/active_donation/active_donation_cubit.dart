import 'package:donor_app/core/enums/donation_status.dart';
import 'package:donor_app/core/networking/api_result.dart';
import 'package:donor_app/features/realtime/domain/entities/realtime_event.dart';
import 'package:donor_app/features/requests/domain/repository/requests_repository.dart';
import 'package:donor_app/features/requests/presentation/logic/active_donation/active_donation_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ActiveDonationCubit extends Cubit<ActiveDonationState> {
  final RequestsRepository _repository;
  ActiveDonationCubit(this._repository)
    : super(const ActiveDonationState.initial());

  String? get currentHospitalName {
    final currentState = state;
    if (currentState is! ActiveDonationSuccess) return null;
    return currentState.donation.hospitalName;
  }

  Future<void> getCurrentActiveDonation() async {
    emit(const ActiveDonationState.loading());

    final result = await _repository.getCurrentActiveDonation();
    result.when(
      success: (data) {
        if (data == null) {
          emit(const ActiveDonationState.empty());
        } else {
          emit(ActiveDonationState.success(data));
        }
      },
      failure: (error) => emit(ActiveDonationState.error(error)),
    );
  }

  void applyRealtimeUpdate(ActiveDonationUpdatedEvent event) {
    switch (event.status) {
      case 'Cancelled':
      case 'NoShow':
        emit(const ActiveDonationState.empty());
        return;
      case 'Fulfilled':
        emit(const ActiveDonationState.empty());
        return;
      case 'Accepted':
        _updateCurrentStatus(DonationStatus.Accepted);
        return;
    }
  }

  void _updateCurrentStatus(DonationStatus status) {
    final currentState = state;
    if (currentState is! ActiveDonationSuccess) return;

    final donation = currentState.donation;
    emit(ActiveDonationState.success(donation.copyWithStatus(status)));
  }
}
