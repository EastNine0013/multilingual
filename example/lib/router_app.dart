import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:multilingual/multilingual.dart';

import 'home.dart';

class RouterApp extends StatefulWidget {
  const RouterApp({super.key});

  @override
  State<RouterApp> createState() => _RouterAppState();
}

class _RouterAppState extends State<RouterApp> {

  @override
  Widget build(BuildContext context) {
    return Multilingual(
        languages: {
          Locale('ko', 'KR'): {'lan': '한국어', 'text_button': '언어변경'},
          Locale('en', 'US'): {'lan': 'English', 'text_button': 'Language change'},
          Locale('ja', 'JP'): {'lan': '日本語', 'text_button': '言語変更'},
        },
        builder: (context) {
          return MaterialApp.router(
            routerConfig: _router,
            localizationsDelegates: MultilingualController.localizationsDelegates,
            supportedLocales: MultilingualController.supportedLocales,
            locale: MultilingualController.locale,
          );
        }
    );
  }
}

final _router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => MultilingualChild(
        builder: (context) => HomeScreen()
      ),
    ),
  ],
);