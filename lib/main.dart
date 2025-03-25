import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logging/logging.dart';
import 'package:pola_flutter/analytics/analytics_main_tab.dart';
import 'package:pola_flutter/analytics/pola_analytics.dart';
import 'package:pola_flutter/i18n/strings.g.dart';
import 'package:pola_flutter/pages/scan/scan_navigator.dart';
import 'package:pola_flutter/theme/assets.gen.dart';
import 'package:pola_flutter/ui/web_view_tab.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (kDebugMode) {
    _setupLogging();
  } else {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  }
  runApp(TranslationProvider(child: PolaApp()));
}

class PolaApp extends StatefulWidget {
  @override
  State<PolaApp> createState() => _PolaAppState();
}

class _PolaAppState extends State<PolaApp> {
  int _selectedIndex = 0;
  final _analytics = PolaAnalytics.instance();

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return MaterialApp(
      theme: ThemeData(
        colorScheme: ColorScheme.light().copyWith(primary: Colors.red),
      ),
      home: DefaultTabController(
        length: 3,
        child: Scaffold(
          bottomNavigationBar: BottomNavigationBar(
            items: <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Assets.scan.searchengine.svg(),
                label: 'Wyszukaj',
              ),
              BottomNavigationBarItem(
                icon: Assets.scan.news.svg(),
                label: 'Aktualności',
              ),
              BottomNavigationBarItem(
                icon: Assets.scan.collections.svg(),
                label: 'Zbiórki',
              ),
            ],
            onTap: _onItemTapped,
            currentIndex: _selectedIndex,
          ),
          body: IndexedStack(
            index: _selectedIndex,
            children: _tabs,
          ),
        ),
      ),
    );
  }

  final List<Widget> _tabs = [
    ScanNavigator(),
    WebViewTab(title: "Wyszukiwarka", url: "https://www.pola-app.pl/m/search/"),
    WebViewTab(title: "Wiadomości", url: "https://www.pola-app.pl/m/blog/")
  ];

  AnalyticsMainTab _getTabParameter(int index) {
    switch (index) {
      case 0:
        return AnalyticsMainTab.scanner;
      case 1:
        return AnalyticsMainTab.search;
      case 2:
        return AnalyticsMainTab.news;
      default:
        return AnalyticsMainTab.scanner;
    }
  }

  void _onItemTapped(int index) {
    _analytics.mainTabChanged(_getTabParameter(index));
    setState(() {
      _selectedIndex = index;
    });
  }
}

class SimpleBlocObserver extends BlocObserver {
  @override
  void onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);
    print(transition);
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    print(error);
    super.onError(bloc, error, stackTrace);
  }
}

void _setupLogging() {
  Bloc.observer = SimpleBlocObserver();
  Logger.root.level = Level.ALL;
  Logger.root.onRecord.listen((rec) {
    print('${rec.level.name}: ${rec.time}: ${rec.message}');
  });
}
