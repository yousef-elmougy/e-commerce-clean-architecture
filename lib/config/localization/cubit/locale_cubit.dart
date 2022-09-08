import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/utiles/app_strings.dart';
import '../domain/use_cases/get_save_locale_usecase.dart';
import '../domain/use_cases/save_locale_usecase.dart';

part 'locale_state.dart';

class LocaleCubit extends Cubit<LocaleState> {
  LocaleCubit(
      {required this.getSavedLocaleUseCase, required this.saveLocaleUseCase})
      : super(const LocaleInitial(locale: Locale(AppStrings.englishCode)));
  final GetSavedLocaleUseCase getSavedLocaleUseCase;
  final SaveLocaleUseCase saveLocaleUseCase;

  String currentCode = AppStrings.englishCode;

  Future<void> saveLocale({required String codeLange}) async {
    final response = await saveLocaleUseCase(codeLange: codeLange);
    response.fold((failure) => debugPrint(AppStrings.cacheFailure), (value) {
      currentCode = codeLange;
      emit(LocaleInitial(locale: _locale(currentCode)));
    });
  }

  Future<void> getSavedLocale() async {
    final getSaved = await getSavedLocaleUseCase.call();
    getSaved.fold((failure) => debugPrint(AppStrings.cacheFailure), (value) {
      currentCode = value;
      emit(LocaleInitial(locale: _locale(currentCode)));
    });
  }

  Locale _locale(String codeLang) {
    switch (codeLang) {
      case AppStrings.englishCode:
        return const Locale(AppStrings.englishCode);

      case AppStrings.arabicCode:
        return const Locale(AppStrings.arabicCode);

      default:
        return const Locale(AppStrings.englishCode);
    }
  }
}
