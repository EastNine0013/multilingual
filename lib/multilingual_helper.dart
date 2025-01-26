import 'package:flutter/material.dart';

import 'multilingual_controller.dart';

class MultilingualHelper {
  MultilingualHelper();

  static final MultilingualHelper instance = MultilingualHelper();
  static final MultilingualController controller = MultilingualController();

  Map<String, dynamic> _sentences = {};

  static MultilingualHelper? get({BuildContext? context}) {
    if (context == null) {
      return MultilingualHelper.instance;
    } else {
      return Localizations.of<MultilingualHelper>(context, MultilingualHelper);
    }
  }

  setLanguages(Map<String, dynamic> sentences) {
    _sentences = sentences;
  }

  add({required String key, required dynamic value}) {
    _sentences[key] = value;
  }

  setLocale(Locale locale) {
    controller.setLocale(locale);
    _sentences = controller.languageList[locale] ?? {};
  }

  addLanguageData({
    required Locale locale,
    required Map<String, dynamic> data,
  }) {
    controller.addLanguageData(locale: locale, data: data);
  }

  removeLanguage(Locale locale) {
    controller.removeLanguage(locale);
  }

  String trans(String key, {Map<String, dynamic>? data}) {
    List<String> keys = key.split('.');
    dynamic value = data ?? _sentences;

    for (String splitKey in keys) {
      if (value is Map && value.containsKey(splitKey)) {
        value = value[splitKey];
      } else {
        value = splitKey;
        break;
      }
    }

    return value.toString();
  }

  T? getData<T>(String key) {
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

  String localeTrans({required Locale locale, required String key}) =>
      trans(key, data: controller.languageList[locale]);
}