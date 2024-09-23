import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// AppLocale class
class AppLocale {
  Locale locale;

  AppLocale(this.locale);

  Map<String, String>? loadedLocalizedValues;

  static AppLocale of(BuildContext context) {
    return Localizations.of<AppLocale>(context, AppLocale)!;
  }

  Future<void> loadLang() async {
    String _langFile = await rootBundle.loadString('assets/language/${locale.languageCode}.json');
    Map<String, dynamic> _loadedValues = jsonDecode(_langFile);
    loadedLocalizedValues = _loadedValues.map((key, value) => MapEntry(key, value.toString()));
  }

  String getTranslated(String key) {
    return loadedLocalizedValues?[key] ?? '$key';
  }

  static const LocalizationsDelegate<AppLocale> delegate = _AppLocalDelegate();
}

class _AppLocalDelegate extends LocalizationsDelegate<AppLocale> {
  const _AppLocalDelegate();

  @override
  bool isSupported(Locale locale) {
    return ["en", "ar"].contains(locale.languageCode);
  }

  @override
  Future<AppLocale> load(Locale locale) async {
    AppLocale appLocale = AppLocale(locale);
    await appLocale.loadLang();
    return appLocale;
  }

  @override
  bool shouldReload(covariant LocalizationsDelegate<AppLocale> old) => false;
}

// Extension for string translation (myname.tr)
extension LocalizationStringExtension on String {
  String tr(BuildContext context) {
    return AppLocale.of(context).getTranslated(this);
  }
}