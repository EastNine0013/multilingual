# Multilingual

`Multilingual` is a powerful Flutter localization plugin that simplifies managing multiple languages in your app. It allows dynamic text translation, runtime language switching, and text replacement.

<a href="https://coff.ee/eastnine0013?ref=multilingual" target="_blank">
      <img src="https://cdn.buymeacoffee.com/buttons/v2/default-yellow.png" alt="Buy Me a Coffee" style="height: 45px; width: 162px;">
</a>

## Features

- **Dynamic Translation**: Use `.trans()` to easily translate text based on the current locale.
- **Custom Text Replacement**: Replace specific text dynamically using `.trans({'key': 'value'});`.
- **Key Existence Check**: Verify if a specific key exists with `context.isTrans('key');`.
- **Support for Multiple Languages**: Seamlessly manage translations for multiple locales.

## Usage

### Basic Setup

Wrap your app with the `Multilingual` widget and define the supported languages:

```dart
class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

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
                home: Scaffold(
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
                ),
              );
            }
    );
  }
}
```

### Creating Your App

Pass the `MultilingualController` to your app and use `.trans()` for translations:

### Checking Key Existence

Use `context.isTrans('key')` to check if a translation key exists:

```dart
if (context.isTrans('key')) {
  print('Translation key exists!');
} else {
  print('Translation key does not exist.');
}
```

### Custom Text Replacement

Replace specific text dynamically:

```dart
Text('Original text'.trans({'Original text': 'Replaced text'}));
```

## Example Output

- Default Language: Korean (`ko_KR`)
    - Button Text: `언어변경`
- Switch to English (`en_US`)
    - Button Text: `Language change`
- Switch to Japanese (`ja_JP`)
    - Button Text: `言語変更`

## Contributing

Feel free to contribute to `Multilingual` by submitting issues or pull requests on the repository.

## License

This project is licensed under the MIT License.

