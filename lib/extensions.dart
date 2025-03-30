import 'dart:io';

import 'package:flutter/material.dart';
import 'package:multilingual/multilingual.dart';

extension StringExtension on String {
  String trans({Map<String, dynamic>? format}) {
    String transStr = MultilingualController.trans(this);

    if (format != null) {
      for (String key in format.keys) {
        transStr = transStr.replaceAll('@{$key}', format[key] ?? '@{$key}');
      }
    }

    return transStr;
  }

  T? getData<T>() => MultilingualController.getData<T>(this);
}
extension ContextExtension on BuildContext {
  Locale get systemLocale => Localizations.localeOf(this);
  Locale get locale => MultilingualController.locale ?? View.of(this).platformDispatcher.locale;
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
    String transStr = MultilingualController.trans(key);
    return key != transStr;
  }
}