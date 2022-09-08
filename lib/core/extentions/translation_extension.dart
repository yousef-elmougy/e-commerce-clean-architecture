import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

extension TranslateX on BuildContext {
  AppLocalizations? get tr => AppLocalizations.of(this);
}
