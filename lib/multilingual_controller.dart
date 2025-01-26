import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'multilingual_helper.dart';

class MultilingualController extends ChangeNotifier {
  MultilingualController();

  Iterable<LocalizationsDelegate<dynamic>> _localizationsDelegates = const [
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate
  ];
  Iterable<LocalizationsDelegate<dynamic>> get localizationsDelegates => _localizationsDelegates;

  late List<Locale> _supportedLocales;
  List<Locale> get supportedLocales => _supportedLocales;

  Locale? _locale;
  Locale? get locale => _locale;

  Map<Locale, Map<String, dynamic>> _languageList = {};
  Map<Locale, Map<String, dynamic>> get languageList => _languageList;

  void initialize({
    required Map<Locale, Map<String, dynamic>> languages,
    Iterable<LocalizationsDelegate<dynamic>>? delegates,
    Locale? defaultLanguage,
  }) {
    _supportedLocales = languages.keys.toList();
    _locale = defaultLanguage ?? _supportedLocales.first;

    List<LocalizationsDelegate<dynamic>> delegateList = _localizationsDelegates.toList();
    delegateList.add(_MultilingualDelegate(languages));

    if (delegates != null) {
      delegateList.addAll(delegates);
    }

    _localizationsDelegates = delegateList;
  }

  setLocale(Locale locale) {
    _locale = locale;
    notifyListeners();
  }

  addLanguageData({
    required Locale locale,
    required Map<String, dynamic> data,
  }) {
    _languageList[locale] = data;
    _supportedLocales.add(locale);
  }

  removeLanguage(Locale locale) {
    _languageList.remove(locale);
    _supportedLocales.remove(locale);
  }
}

class _MultilingualDelegate extends LocalizationsDelegate<MultilingualHelper> {
  _MultilingualDelegate(this._languages);

  final Map<Locale, Map<String, dynamic>> _languages;

  @override
  bool isSupported(Locale locale) =>
      _languages.keys.map((e) => e.languageCode).contains(locale.languageCode);

  @override
  Future<MultilingualHelper> load(Locale locale) async {
    MultilingualHelper localizations = MultilingualHelper.instance;
    localizations.setLocale(locale);
    localizations.setLanguages(_languages[locale] ?? {});
    return localizations;
  }

  @override
  bool shouldReload(covariant LocalizationsDelegate<MultilingualHelper> old) => false;
}