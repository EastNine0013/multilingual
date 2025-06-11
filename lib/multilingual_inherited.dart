import 'package:flutter/material.dart';

class MultilingualInherited extends InheritedWidget {
  const MultilingualInherited({
    super.key,
    required super.child,
    required this.locale,
  });

  final Locale locale;

  @override
  bool updateShouldNotify(MultilingualInherited oldWidget) => oldWidget.locale != locale;

  static MultilingualInherited? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<MultilingualInherited>();
  }
}