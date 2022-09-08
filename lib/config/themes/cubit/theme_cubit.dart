import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shop_clean_architecture/core/utiles/app_strings.dart';

part 'theme_state.dart';

class ThemeCubit extends Cubit<ThemeState> {
  ThemeCubit({required this.sharedPreferences}) : super(ThemeInitial());

  final SharedPreferences sharedPreferences;

  /// THEME MODE
  bool switchValue = false;

  void cacheTheme(bool isDark) =>
      sharedPreferences.setBool(AppStrings.themeKey, isDark);

  bool getCachedTheme() => sharedPreferences.getBool(AppStrings.themeKey) ?? false;

  ThemeMode get themeDataGet =>
      getCachedTheme() ? ThemeMode.dark : ThemeMode.light;

  void changeTheme() {
    cacheTheme(!getCachedTheme());
    emit(ThemeSuccessState(!getCachedTheme()));
  }
/// Switch
 void changeSwitch(bool value){
    switchValue = value;
    emit(ChangeSwitchState());
  }
}
