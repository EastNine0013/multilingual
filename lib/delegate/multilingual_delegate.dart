import 'package:flutter/material.dart';
import 'package:multilingual/multilingual_inherited.dart';

class MultilingualDelegate extends LocalizationsDelegate<MultilingualInherited?> {
  MultilingualDelegate(this.context, this.languages);

  final BuildContext context;
  final Map<Locale, Map<String, dynamic>> languages;

  @override
  bool isSupported(Locale locale) =>
      languages.keys.map((e) => e.languageCode).contains(locale.languageCode);

  @override
  Future<MultilingualInherited?> load(Locale locale) async {
    MultilingualInherited? localizations = MultilingualInherited.of(context);
    return localizations;
  }

  @override
  bool shouldReload(covariant LocalizationsDelegate<MultilingualInherited?> old) => false;
}