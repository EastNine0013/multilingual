import 'package:flutter/material.dart';
import 'package:multilingual/extensions.dart';
import 'package:multilingual/multilingual.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      title: const Text('Plugin example app'),
    ),
    body: Center(
      child: Column(
        children: [
          Text('lan'.trans()),
          TextButton(onPressed: () {
            Locale? locale = MultilingualController.locale;
            Locale loc;
            if (locale.toString() == 'ko_KR') {
              loc = const Locale('en', 'US');
            } else if (locale.toString() == 'en_US') {
              loc = const Locale('ja', 'JP');
            } else {
              loc = const Locale('ko', 'KR');
            }
            MultilingualController.setLocale(loc);
          }, child: Text('text_button'.trans())),
        ],
      ),
    ),
  );
}