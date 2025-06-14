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
#### Wrap your app with the `Multilingual` widget and define the supported languages.<br>Add `yourWidget` inside the `builder` of `MultilingualChild`.

##### Using Flutter's default `MaterialApp`:

```dart
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
```
##### Using `MaterialApp.router` provided by `go_router`:
```dart
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
```

#### Your Widget:

```dart
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
```

<H4>Note: Do not use `const` with `yourWidget`. Using `const` will prevent the screen from updating.</H4><br>

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

