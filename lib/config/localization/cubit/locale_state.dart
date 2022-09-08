part of 'locale_cubit.dart';

abstract class LocaleState extends Equatable {
  final Locale locale;

  const LocaleState({ required this.locale});
  @override
  List<Object> get props => [locale];
}

class LocaleInitial extends LocaleState {
  const LocaleInitial({required super.locale});
}
