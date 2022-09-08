part of 'theme_cubit.dart';

@immutable
abstract class ThemeState {}

class ThemeInitial extends ThemeState {}
class ThemeSuccessState extends ThemeState {
  final bool isDark;

  ThemeSuccessState(this.isDark);
}
class ChangeSwitchState extends ThemeState {}
