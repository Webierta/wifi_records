import 'package:flutter/material.dart';

import 'en.dart';
import 'es.dart';
import 'loc_keys.dart';

extension LocalizationExt on BuildContext {
  String trans(LocKeys value) {
    final code = AppLocalization.of(this)?.locale.languageCode ?? 'en';
    final database = AppLocalization._db;
    if (database.containsKey(code)) {
      return database[code]?[value] ?? '-';
    } else {
      return database['en']?[value] ?? '-';
    }
  }
}

class AppLocalization {
  final Locale locale;
  const AppLocalization(this.locale);

  static AppLocalization? of(BuildContext ctx) =>
      Localizations.of<AppLocalization>(ctx, AppLocalization);

  static Map<String, Map<LocKeys, String>> _db = const {
    'en': langEn,
    'es': langEs,
  };
}
