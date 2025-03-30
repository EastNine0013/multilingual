import 'package:flutter/material.dart';

typedef OnSetLocale = Function(Locale);
typedef OnSetLanguages = Function(Map<String, dynamic> sentences);

class MultilingualInherited extends InheritedWidget {
  const MultilingualInherited({
    super.key,
    required super.child,
    required this.locale,
    required this.setLocale,
    required this.setLanguages,
  });

  final Locale locale;
  final OnSetLocale setLocale;
  final OnSetLanguages setLanguages;

  @override
  bool updateShouldNotify(MultilingualInherited oldWidget) => oldWidget.locale == locale;

  static MultilingualInherited? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<MultilingualInherited>();
  }
}