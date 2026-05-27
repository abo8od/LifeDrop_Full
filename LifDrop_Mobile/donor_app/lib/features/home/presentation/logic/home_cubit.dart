import 'package:donor_app/core/helpers/biometric_helper.dart';
import 'package:donor_app/core/helpers/constants.dart';
import 'package:donor_app/core/helpers/shared_pref_helper.dart';
import 'package:donor_app/core/enums/blood_type.dart';
import 'package:donor_app/core/enums/urgency_status.dart';
import 'package:donor_app/core/networking/api_result.dart';
import 'package:donor_app/features/home/domain/entities/donation_request_entity.dart';
import 'package:donor_app/features/home/domain/entities/home_data_entity.dart';
import 'package:donor_app/features/home/domain/repositories/home_repository.dart';
import 'package:donor_app/features/home/presentation/logic/home_state.dart';
import 'package:donor_app/features/realtime/domain/entities/realtime_event.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeCubit extends Cubit<HomeState> {
  static const int donationCooldownDays = 90;

  final BiometricHelper _biometricHelper;
  final HomeRepository _homeRepository;

  HomeCubit({
    required BiometricHelper biometricHelper,
    required HomeRepository homeRepository,
  }) : _biometricHelper = biometricHelper,
       _homeRepository = homeRepository,
       super(const HomeState.initial());

  Future<void> loadHome() async {
    emit(const HomeState.loading());
    final result = await _homeRepository.getHomeData();

    result.when(
      success: (data) => emit(HomeState.success(data)),
      failure: (error) => emit(HomeState.error(error)),
    );
  }

  Future<void> checkBiometricPrompt() async {
    final alreadyShown = await SharedPrefHelper.getBool(
      SharedPrefKeys.biometricPromptShown,
    );
    if (alreadyShown) return;

    final isCapable = await _biometricHelper.isDeviceCapable();
    final isAvailable = await _biometricHelper.isBiometricEnabled();

    if (isCapable && isAvailable) {
      emit(const HomeState.biometricPromptRequired());
    }
  }

  void addRealtimeDonationRequest(NewDonationRequestEvent event) {
    final currentState = state;
    if (currentState is! HomeSuccess) return;

    final request = DonationRequestEntity(
      requestId: event.requestId,
      bloodType: _bloodTypeFromIndex(event.requiredBloodType),
      urgency: _urgencyFromIndex(event.urgency),
      hospitalName: event.hospitalName,
    );

    final activeRequests = [
      request,
      ...currentState.data.activeRequests.where(
        (item) => item.requestId != event.requestId,
      ),
    ];

    emit(
      HomeState.success(
        _copyHomeData(currentState.data, activeRequests: activeRequests),
      ),
    );
  }

  void markDonationFulfilled({required String hospitalName}) {
    final currentState = state;
    if (currentState is! HomeSuccess) return;

    emit(
      HomeState.success(
        _copyHomeData(
          currentState.data,
          lastHospitalName: hospitalName,
          remainingDays: donationCooldownDays,
          totalContributions: currentState.data.totalContributions + 1,
        ),
      ),
    );
  }

  Future<void> refreshAfterDonationFulfilled({String? hospitalName}) async {
    await loadHome();
    if (hospitalName == null || hospitalName.isEmpty) return;
    markDonationFulfilled(hospitalName: hospitalName);
  }

  HomeDataEntity _copyHomeData(
    HomeDataEntity data, {
    String? lastHospitalName,
    int? remainingDays,
    int? totalContributions,
    List<DonationRequestEntity>? activeRequests,
  }) {
    return HomeDataEntity(
      username: data.username,
      lastHospitalName: lastHospitalName ?? data.lastHospitalName,
      remainingDays: remainingDays ?? data.remainingDays,
      totalContributions: totalContributions ?? data.totalContributions,
      activeRequests: activeRequests ?? data.activeRequests,
    );
  }

  BloodType _bloodTypeFromIndex(int index) {
    if (index < 0 || index >= BloodType.values.length) {
      return BloodType.O_Positive;
    }
    return BloodType.values[index];
  }

  UrgencyStatus _urgencyFromIndex(int index) {
    if (index < 0 || index >= UrgencyStatus.values.length) {
      return UrgencyStatus.Normal;
    }
    return UrgencyStatus.values[index];
  }
}
