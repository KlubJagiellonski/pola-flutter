import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logging/logging.dart';
import 'package:pola_flutter/analytics/analytics_main_tab.dart';
import 'package:pola_flutter/analytics/pola_analytics.dart';
import 'package:pola_flutter/i18n/strings.g.dart';
import 'package:pola_flutter/models/search_result.dart';
import 'package:pola_flutter/pages/dialpad/dialpad.dart';
import 'package:pola_flutter/pages/scan/scan.dart';
import 'package:pola_flutter/ui/web_view_tab.dart';
import 'firebase_options.dart';
import 'pages/detail/detail.dart';

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
      onGenerateRoute: RouteGenerator.generateRoute,
      home: DefaultTabController(
        length: 3,
        child: Scaffold(
            bottomNavigationBar: BottomNavigationBar(
              items: const <BottomNavigationBarItem>[
                BottomNavigationBarItem(
                  icon: Icon(Icons.smartphone),
                  label: 'Skaner kodów',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.search),
                  label: 'Wyszukiwarka',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.newspaper),
                  label: 'Wiadomości',
                ),
              ],
              onTap: _onItemTapped,
              currentIndex: _selectedIndex,
            ),
            body: IndexedStack(
              index: _selectedIndex,
              children: _tabs,
            )),
      ),
    );
  }

  final List<Widget> _tabs = [
    MainPage(),
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

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments;

    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => MainPage());
      case '/detail':
        if (args is SearchResult) {
          return MaterialPageRoute(
            builder: (_) => DetailPage(
              searchResult: args,
            ),
          );
        }
        return MaterialPageRoute(builder: (_) => MainPage());
      case '/dialpad':
        return MaterialPageRoute(builder: (_) => DialPadPage());
      default:
        return MaterialPageRoute(builder: (_) => MainPage());
    }
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
