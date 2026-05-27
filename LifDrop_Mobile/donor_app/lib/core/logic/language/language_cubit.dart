import 'package:donor_app/core/helpers/constants.dart';
import 'package:donor_app/core/helpers/shared_pref_helper.dart';
import 'package:donor_app/core/logic/language/language_state.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

class LanguageCubit extends Cubit<LanguageState> {
  LanguageCubit() : super(const LanguageState(locale: Locale('en')));

  Future<void> loadLanguage() async {
    final saved = await SharedPrefHelper.getString(SharedPrefKeys.appLanguage);
    if (saved.isNotEmpty && _isSupported(saved)) {
      emit(LanguageState(locale: Locale(saved)));
    } else {
      final deviceLocale = PlatformDispatcher.instance.locale;
      final langCode = _isSupported(deviceLocale.languageCode)
          ? deviceLocale.languageCode
          : 'en';

      emit(state.copyWith(locale: Locale(langCode)));
    }
  }

  Future<void> changeLanguage(String languageCode) async {
    await SharedPrefHelper.setData(SharedPrefKeys.appLanguage, languageCode);
    emit(state.copyWith(locale: Locale(languageCode)));
  }

  bool _isSupported(String code) => ['en', 'ar'].contains(code);
}
