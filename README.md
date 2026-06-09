# Aplikacja Pola 🇵🇱

[![Build Status](https://github.com/KlubJagiellonski/pola-android/workflows/Tests/badge.svg)](https://github.com/KlubJagiellonski/pola-flutter/actions)

Pola pomoże Ci odnaleźć polskie wyroby. Zabierając Polę na zakupy odnajdujesz produkty “z duszą” i wspierasz polską gospodarkę.  
Aplikacja jest dostępna w sklepie Google Play oraz na stronie [pola-app.pl](https://www.pola-app.pl/)


Pola will help you find polish products. Taking Pola on shopping will let you find products with soul and support Polish economy.  
Currently available on Play store and [pola-app.pl](https://www.pola-app.pl/)


# Uruchomienie

Część plików jest generowana, dlatego przed pierwszym uruchomieniem aplikacji czy też po zmianie brancha warto uruchomić build_runnera i [slanga](https://github.com/slang-i18n/slang):

```bash
dart run build_runner build
dart run slang
```

W trakcie prac nad plikami, które powodują konieczność ponownego uruchomienia build_runnera warto użyc:

```bash
dart run build_runner watch
```

Do lokalnego uruchamiania aplikacji bez konfiguracji Firebase użyj flavoru `dev`:

```bash
flutter run --flavor dev
```

Flavor'y `qa` i `prod` wymagają konfiguracji Firebase oraz jawnego włączenia Firebase w warstwie Dart:

```bash
flutter run --flavor qa --dart-define=FIREBASE_ENABLED=true
flutter run --flavor prod --dart-define=FIREBASE_ENABLED=true
```

Plik `ios/Runner/GoogleService-Info.plist` nie jest trzymany w repozytorium. Do lokalnego uruchamiania `qa` lub `prod` trzeba dodać go ręcznie. Workflow iOS odtwarza ten plik z sekretu GitHub `IOS_GOOGLE_SERVICE_INFO_PLIST_BASE64`.

```bash
base64 -i ios/Runner/GoogleService-Info.plist | tr -d '[:space:]'
```

# Screenshoty

TODO

# Kontrybucja

Odwiedź zakładkę [Issues](https://github.com/KlubJagiellonski/pola-flutter/issues) aby znaleźć pomysły na nowe funkcjonalności.
