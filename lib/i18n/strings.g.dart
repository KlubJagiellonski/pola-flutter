/// Generated file. Do not edit.
///
/// Original: lib/i18n
/// To regenerate, run: `dart run slang`
///
/// Locales: 1
/// Strings: 19
///
/// Built on 2024-08-05 at 10:55 UTC

// coverage:ignore-file
// ignore_for_file: type=lint

import 'package:flutter/widgets.dart';
import 'package:slang/builder/model/node.dart';
import 'package:slang_flutter/slang_flutter.dart';
export 'package:slang_flutter/slang_flutter.dart';

const AppLocale _baseLocale = AppLocale.en;

/// Supported locales, see extension methods below.
///
/// Usage:
/// - LocaleSettings.setLocale(AppLocale.en) // set locale
/// - Locale locale = AppLocale.en.flutterLocale // get flutter locale from enum
/// - if (LocaleSettings.currentLocale == AppLocale.en) // locale check
enum AppLocale with BaseAppLocale<AppLocale, Translations> {
	en(languageCode: 'en', build: Translations.build);

	const AppLocale({required this.languageCode, this.scriptCode, this.countryCode, required this.build}); // ignore: unused_element

	@override final String languageCode;
	@override final String? scriptCode;
	@override final String? countryCode;
	@override final TranslationBuilder<AppLocale, Translations> build;

	/// Gets current instance managed by [LocaleSettings].
	Translations get translations => LocaleSettings.instance.translationMap[this]!;
}

/// Method A: Simple
///
/// No rebuild after locale change.
/// Translation happens during initialization of the widget (call of t).
/// Configurable via 'translate_var'.
///
/// Usage:
/// String a = t.someKey.anotherKey;
/// String b = t['someKey.anotherKey']; // Only for edge cases!
Translations get t => LocaleSettings.instance.currentTranslations;

/// Method B: Advanced
///
/// All widgets using this method will trigger a rebuild when locale changes.
/// Use this if you have e.g. a settings page where the user can select the locale during runtime.
///
/// Step 1:
/// wrap your App with
/// TranslationProvider(
/// 	child: MyApp()
/// );
///
/// Step 2:
/// final t = Translations.of(context); // Get t variable.
/// String a = t.someKey.anotherKey; // Use t variable.
/// String b = t['someKey.anotherKey']; // Only for edge cases!
class TranslationProvider extends BaseTranslationProvider<AppLocale, Translations> {
	TranslationProvider({required super.child}) : super(settings: LocaleSettings.instance);

	static InheritedLocaleData<AppLocale, Translations> of(BuildContext context) => InheritedLocaleData.of<AppLocale, Translations>(context);
}

/// Method B shorthand via [BuildContext] extension method.
/// Configurable via 'translate_var'.
///
/// Usage (e.g. in a widget's build method):
/// context.t.someKey.anotherKey
extension BuildContextTranslationsExtension on BuildContext {
	Translations get t => TranslationProvider.of(this).translations;
}

/// Manages all translation instances and the current locale
class LocaleSettings extends BaseFlutterLocaleSettings<AppLocale, Translations> {
	LocaleSettings._() : super(utils: AppLocaleUtils.instance);

	static final instance = LocaleSettings._();

	// static aliases (checkout base methods for documentation)
	static AppLocale get currentLocale => instance.currentLocale;
	static Stream<AppLocale> getLocaleStream() => instance.getLocaleStream();
	static AppLocale setLocale(AppLocale locale, {bool? listenToDeviceLocale = false}) => instance.setLocale(locale, listenToDeviceLocale: listenToDeviceLocale);
	static AppLocale setLocaleRaw(String rawLocale, {bool? listenToDeviceLocale = false}) => instance.setLocaleRaw(rawLocale, listenToDeviceLocale: listenToDeviceLocale);
	static AppLocale useDeviceLocale() => instance.useDeviceLocale();
	@Deprecated('Use [AppLocaleUtils.supportedLocales]') static List<Locale> get supportedLocales => instance.supportedLocales;
	@Deprecated('Use [AppLocaleUtils.supportedLocalesRaw]') static List<String> get supportedLocalesRaw => instance.supportedLocalesRaw;
	static void setPluralResolver({String? language, AppLocale? locale, PluralResolver? cardinalResolver, PluralResolver? ordinalResolver}) => instance.setPluralResolver(
		language: language,
		locale: locale,
		cardinalResolver: cardinalResolver,
		ordinalResolver: ordinalResolver,
	);
}

/// Provides utility functions without any side effects.
class AppLocaleUtils extends BaseAppLocaleUtils<AppLocale, Translations> {
	AppLocaleUtils._() : super(baseLocale: _baseLocale, locales: AppLocale.values);

	static final instance = AppLocaleUtils._();

	// static aliases (checkout base methods for documentation)
	static AppLocale parse(String rawLocale) => instance.parse(rawLocale);
	static AppLocale parseLocaleParts({required String languageCode, String? scriptCode, String? countryCode}) => instance.parseLocaleParts(languageCode: languageCode, scriptCode: scriptCode, countryCode: countryCode);
	static AppLocale findDeviceLocale() => instance.findDeviceLocale();
	static List<Locale> get supportedLocales => instance.supportedLocales;
	static List<String> get supportedLocalesRaw => instance.supportedLocalesRaw;
}

// translations

// Path: <root>
class Translations implements BaseTranslations<AppLocale, Translations> {
	/// Returns the current translations of the given [context].
	///
	/// Usage:
	/// final t = Translations.of(context);
	static Translations of(BuildContext context) => InheritedLocaleData.of<AppLocale, Translations>(context).translations;

	/// You can call this constructor and build your own translation instance of this locale.
	/// Constructing via the enum [AppLocale.build] is preferred.
	Translations.build({Map<String, Node>? overrides, PluralResolver? cardinalResolver, PluralResolver? ordinalResolver})
		: assert(overrides == null, 'Set "translation_overrides: true" in order to enable this feature.'),
		  $meta = TranslationMetadata(
		    locale: AppLocale.en,
		    overrides: overrides ?? {},
		    cardinalResolver: cardinalResolver,
		    ordinalResolver: ordinalResolver,
		  ) {
		$meta.setFlatMapFunction(_flatMapFunction);
	}

	/// Metadata for the translations of <en>.
	@override final TranslationMetadata<AppLocale, Translations> $meta;

	/// Access flat map
	dynamic operator[](String key) => $meta.getTranslation(key);

	late final Translations _root = this; // ignore: unused_field

	// Translations
	late final _StringsMenuEn menu = _StringsMenuEn._(_root);
	late final _StringsCompanyScreenEn companyScreen = _StringsCompanyScreenEn._(_root);
}

// Path: menu
class _StringsMenuEn {
	_StringsMenuEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get aboutPola => 'O aplikacji Pola';
	String get aboutClub => ' O Klubie Jagielońskim';
	String get instruction => 'Jak oceniamy Firmy';
	String get partners => 'Partnerzy';
	String get polasFriends => 'Przyjaciele Poli';
	String get rateUS => 'Oceń Polę';
	String get team => 'Zespół';
	String get findUs => 'Znajdź nas tutaj';
	String get footer => 'Aplikacja Pola \n© Klub Jagielloński';
}

// Path: companyScreen
class _StringsCompanyScreenEn {
	_StringsCompanyScreenEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get ourRating => 'Nasza ocena:';
	String get gradingCriteria => 'Kryteria oceniania:';
	String get polishCapital => 'Polski kapitał';
	String get producedInPoland => 'Produkuje w Polsce';
	String get researchInPoland => 'Prowadzi badania w Polsce';
	String get registeredInPoland => 'Zarejestrowana w Polsce';
	String get notConcernPart => 'Nie jest częścią zagranicznego koncernu';
	String get seeMore => 'zobacz więcej';
	String get seeLess => 'zobacz mniej';
	String points({required Object score}) => 'pkt ${score}';
}

/// Flat map(s) containing all translations.
/// Only for edge cases! For simple maps, use the map function of this library.

extension on Translations {
	dynamic _flatMapFunction(String path) {
		switch (path) {
			case 'menu.aboutPola': return 'O aplikacji Pola';
			case 'menu.aboutClub': return ' O Klubie Jagielońskim';
			case 'menu.instruction': return 'Jak oceniamy Firmy';
			case 'menu.partners': return 'Partnerzy';
			case 'menu.polasFriends': return 'Przyjaciele Poli';
			case 'menu.rateUS': return 'Oceń Polę';
			case 'menu.team': return 'Zespół';
			case 'menu.findUs': return 'Znajdź nas tutaj';
			case 'menu.footer': return 'Aplikacja Pola \n© Klub Jagielloński';
			case 'companyScreen.ourRating': return 'Nasza ocena:';
			case 'companyScreen.gradingCriteria': return 'Kryteria oceniania:';
			case 'companyScreen.polishCapital': return 'Polski kapitał';
			case 'companyScreen.producedInPoland': return 'Produkuje w Polsce';
			case 'companyScreen.researchInPoland': return 'Prowadzi badania w Polsce';
			case 'companyScreen.registeredInPoland': return 'Zarejestrowana w Polsce';
			case 'companyScreen.notConcernPart': return 'Nie jest częścią zagranicznego koncernu';
			case 'companyScreen.seeMore': return 'zobacz więcej';
			case 'companyScreen.seeLess': return 'zobacz mniej';
			case 'companyScreen.points': return ({required Object score}) => 'pkt ${score}';
			default: return null;
		}
	}
}
