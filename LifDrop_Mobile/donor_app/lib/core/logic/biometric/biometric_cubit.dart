import 'dart:developer';

import 'package:donor_app/core/helpers/constants.dart';
import 'package:donor_app/core/helpers/shared_pref_helper.dart';
import 'package:donor_app/core/logic/biometric/biometric_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:local_auth/local_auth.dart';

class BiometricCubit extends Cubit<BiometricState> {
  BiometricCubit() : super(const BiometricState(isEnabled: false));

  Future<void> init() async {
    final isEnabled = await SharedPrefHelper.getBool(
      SharedPrefKeys.biometricEnabled,
    );

    if (isClosed) return;

    emit(state.copyWith(isEnabled: isEnabled));
  }

  Future<void> toggle(bool value) async {
    if (value) {
      final didAuth = await LocalAuthentication().authenticate(
        localizedReason: 'Confirm to enable biometric login',
      );

      if (!didAuth) return;
    }
    await SharedPrefHelper.setData(SharedPrefKeys.biometricEnabled, value);

    if (isClosed) {
      log('Biometric Cubit is Closed');
      return;
    }

    emit(state.copyWith(isEnabled: value));
  }
}
