import 'package:donor_app/core/helpers/constants.dart';
import 'package:donor_app/core/helpers/shared_pref_helper.dart';
import 'package:donor_app/core/logic/theme/theme_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ThemeCubit extends Cubit<ThemeState> {
  ThemeCubit() : super(const ThemeState(themeMode: ThemeMode.system));

  Future<void> loadTheme() async {
    final index = await SharedPrefHelper.getInt(SharedPrefKeys.themeMode);
    emit(state.copyWith(themeMode: ThemeMode.values[index]));
  }

  Future<void> setTheme(ThemeMode mode) async {
    await SharedPrefHelper.setData(SharedPrefKeys.themeMode, mode.index);
    emit(state.copyWith(themeMode: mode));
  }
}
