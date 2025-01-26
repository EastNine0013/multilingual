import 'package:flutter/material.dart';
import 'package:multilingual/extensions.dart';
import 'package:multilingual/multilingual.dart';
import 'package:multilingual/multilingual_controller.dart';

void main() {
  runApp(Multilingual(
      languages: {
        Locale('ko', 'KR'): {'lan': '한국어', 'text_button': '언어변경'},
        Locale('en', 'US'): {'lan': 'English', 'text_button': 'Language change'},
        Locale('ja', 'JP'): {'lan': '日本語', 'text_button': '言語変更'},
      },
      builder: (context, controller) {
        return MyApp(controller);
      }
  ));
}

class MyApp extends StatefulWidget {
  const MyApp(this.controller, {super.key});

  final MultilingualController controller;

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: widget.controller.localizationsDelegates,
      supportedLocales: widget.controller.supportedLocales,
      locale: widget.controller.locale,
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Center(
          child: Column(
            children: [
              Text('lan'.trans()),
              TextButton(onPressed: () {
                Locale? locale = widget.controller.locale;
                Locale loc;
                if (locale.toString() == 'ko_KR') {
                  loc = const Locale('en', 'US');
                } else if (locale.toString() == 'en_US') {
                  loc = const Locale('ja', 'JP');
                } else {
                  loc = const Locale('ko', 'KR');
                }
                widget.controller.setLocale(loc);
              }, child: Text('text_button'.trans())),
            ],
          ),
        ),
      ),
    );
  }
}
