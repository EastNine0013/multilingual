import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'delegate/multilingual_delegate.dart';
import 'multilingual_inherited.dart';

typedef MultilingualBuilder = Function(BuildContext context);

class Multilingual extends StatefulWidget {
  const Multilingual({
    required this.builder,
    required this.languages,
    super.key,
    this.delegates,
    this.defaultLanguages,
  });

  final MultilingualBuilder builder;
  final Iterable<LocalizationsDelegate<dynamic>>? delegates;
  final Map<Locale, Map<String, dynamic>> languages;
  final Locale? defaultLanguages;

  @override
  State<Multilingual> createState() => _MultilingualState();
}

class _MultilingualState extends State<Multilingual> {
  @override
  void initState() {
    super.initState();
    MultilingualController._addListener(_controllerListener);
  }

  @override
  void dispose() {
    MultilingualController._removeListener(_controllerListener);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!MultilingualController._isInitialized) {
      MultilingualController._initController(
        context: context,
        languages: widget.languages,
        delegates: widget.delegates,
        defaultLanguage: widget.defaultLanguages,
      );
    }

    return MultilingualInherited(
      locale: MultilingualController.locale,
      child: widget.builder(context),
    );
  }

  _controllerListener() {
    setState(() {});
  }
}

class MultilingualController {
  MultilingualController ._();

  static bool _isInitialized = false;

  static final Set<VoidCallback> _listeners = {};

  static Map<String, dynamic> _sentences = {};

  static List<Locale> _supportedLocales = List.empty(growable: true);
  static List<Locale> get supportedLocales => _supportedLocales;

  static Locale _locale = const Locale('en', 'US');
  static Locale get locale => _locale;

  static Iterable<LocalizationsDelegate<dynamic>> _localizationsDelegates = const [
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate
  ];
  static Iterable<LocalizationsDelegate<dynamic>> get localizationsDelegates => _localizationsDelegates;

  static final Map<Locale, Map<String, dynamic>> _languageList = {};
  static Map<Locale, Map<String, dynamic>> get languageList => _languageList;

  static _initController({
    required BuildContext context,
    required Map<Locale, Map<String, dynamic>> languages,
    Iterable<LocalizationsDelegate<dynamic>>? delegates,
    Locale? defaultLanguage,
  }) {
    List<Locale> locales = languages.keys.toList();
    _supportedLocales = List.from(locales, growable: true);
    _locale = defaultLanguage ?? _supportedLocales.first;

    Map<String, dynamic>? language = languages[_locale];
    if (language != null) {
      setLanguages(language);
    }

    List<LocalizationsDelegate<dynamic>> delegateList = _localizationsDelegates.toList();
    delegateList.add(MultilingualDelegate(context, languages));

    for (Locale locale in locales) {
      addLanguageData(locale: locale, data: languages[locale] ?? {});
    }

    if (delegates != null) {
      delegateList.addAll(delegates);
    }

    _localizationsDelegates = delegateList;

    _isInitialized = true;
  }

  static _addListener(VoidCallback listener) {
    _listeners.add(listener);
  }

  static _removeListener(VoidCallback listener) {
    _listeners.remove(listener);
  }

  static setLanguages(Map<String, dynamic> sentences) {
    _sentences = sentences;
  }

  static add({required String key, required dynamic value}) {
    _sentences[key] = value;
  }

  static addLanguageData({
    required Locale locale,
    required Map<String, dynamic> data,
  }) {
    _languageList[locale] = data;
    _supportedLocales.add(locale);
  }

  static removeLanguage(Locale locale) {
    _languageList.remove(locale);
    _supportedLocales.remove(locale);
  }

  static String trans(String key, {Map<String, dynamic>? data}) {
    List<String> keys = key.split('.');
    dynamic value = data ?? _sentences;

    for (String splitKey in keys) {
      if (value is Map && value.containsKey(splitKey)) {
        value = value[splitKey];
      } else {
        value = key;
        break;
      }
    }

    return value.toString();
  }

  static T? getData<T>(String key) {
    List<String> keys = key.split('.');
    dynamic value = _sentences;

    for (String splitKey in keys) {
      if (value is Map && value.containsKey(splitKey)) {
        value = value[splitKey];
      } else {
        return null;
      }
    }

    return value as T;
  }

  static String localeTrans({required Locale locale, required String key}) =>
      trans(key, data: languageList[locale]);

  static setLocale(Locale locale) {
    _locale = locale;
    _sentences = languageList[locale] ?? {};
    for (VoidCallback listener in _listeners) {
      listener.call();
    }
  }
}