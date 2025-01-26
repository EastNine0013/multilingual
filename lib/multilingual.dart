import 'package:flutter/material.dart';

import 'multilingual_controller.dart';
import 'multilingual_helper.dart';

typedef MultilingualBuilder = Function(BuildContext context, MultilingualController controller);

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
    MultilingualHelper.controller.initialize(
      languages: widget.languages,
      delegates: widget.delegates,
      defaultLanguage: widget.defaultLanguages,
    );
    super.initState();

    MultilingualHelper.controller.addListener(_localizationListener);
  }

  @override
  void dispose() {
    MultilingualHelper.controller.removeListener(_localizationListener);
    super.dispose();
  }
  @override
  Widget build(BuildContext context) => widget.builder(context, MultilingualHelper.controller);

  _localizationListener() {
    WidgetsBinding.instance.addPersistentFrameCallback((timeStamp) {
      setState(() {});
    });
  }
}