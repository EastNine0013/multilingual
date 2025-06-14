import 'package:flutter/material.dart';
import 'package:multilingual/multilingual.dart';

import 'home.dart';

class DefaultApp extends StatefulWidget {
  const DefaultApp({super.key});

  @override
  State<DefaultApp> createState() => _DefaultAppState();
}

class _DefaultAppState extends State<DefaultApp> {

  @override
  Widget build(BuildContext context) {
    return Multilingual(
        languages: {
          Locale('ko', 'KR'): {'lan': '한국어', 'text_button': '언어변경'},
          Locale('en', 'US'): {'lan': 'English', 'text_button': 'Language change'},
          Locale('ja', 'JP'): {'lan': '日本語', 'text_button': '言語変更'},
        },
        builder: (context) {
          return MaterialApp(
            localizationsDelegates: MultilingualController.localizationsDelegates,
            supportedLocales: MultilingualController.supportedLocales,
            locale: MultilingualController.locale,
            home: MultilingualChild(
              builder: (context) {
                return HomeScreen();
              }
            ),
          );
        }
    );
  }
}
