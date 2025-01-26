import 'dart:io';

import 'package:flutter/material.dart';

import 'multilingual_helper.dart';

extension StringExtension on String {
  String trans({Map<String, dynamic>? format}) {
    String transStr = MultilingualHelper.instance.trans(this);

    if (format != null) {
      for (String key in format.keys) {
        transStr = transStr.replaceAll('@{$key}', format[key] ?? '@{$key}');
      }
    }

    return transStr;
  }

  T? getData<T>() => MultilingualHelper.instance.getData<T>(this);
}

extension ContextExtension on BuildContext {
  Locale get systemLocale => Localizations.localeOf(this);
  Locale get locale => MultilingualHelper.controller.locale ?? View.of(this).platformDispatcher.locale;
  String get language => locale.toString();
  Locale get platformLocale {
    String languageCode = '';
    String? countryCode;
    String localeName = Platform.localeName;
    if (localeName.contains('_')) {
      languageCode = localeName.split('_')[0];
      countryCode = localeName.split('_')[1];
    } else {
      languageCode = localeName;
    }

    return Locale(languageCode, countryCode);
  }

  bool isTrans(String key) {
    String transStr = MultilingualHelper.instance.trans(key);
    return key != transStr;
  }
}