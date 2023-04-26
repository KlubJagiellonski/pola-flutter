import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logging/logging.dart';
import 'package:pola_flutter/models/search_result.dart';
import 'package:pola_flutter/pages/dialpad/dialpad.dart';
import 'package:pola_flutter/pages/scan/scan.dart';
import 'package:pola_flutter/pages/web/web.dart';
import 'package:pola_flutter/pages/web/web_tab.dart';
import 'pages/detail/detail.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (kDebugMode) {
    _setupLogging();
  } else {
    await Firebase.initializeApp();
  }
  runApp(PolaApp());
}

class PolaApp extends StatefulWidget {
  @override
  State<PolaApp> createState() => _PolaAppState();
}

class _PolaAppState extends State<PolaApp> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.red,
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
                  label: 'Wiadomośći',
                ),
              ],
              onTap: _onItemTapped,
              currentIndex: _selectedIndex,
            ),
            body: _getTabContentWidget()),
      ),
    );
  }

  Widget _getTabContentWidget() {
    switch (_selectedIndex) {
      case 0:
        return MainPage();
      case 1:
        return WebViewTabPage(
            title: "Wyszukiwarka",
            url: "https://www.pola-app.pl/m/search/");
      case 2:
        return WebViewTabPage(
            title: "Wiadomości",
            url: "https://www.pola-app.pl/m/blog/");
      default:
        return MainPage();
    }
  }

  void _onItemTapped(int index) {
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
      case '/web':
        if (args is String) {
          return MaterialPageRoute(
            builder: (_) => WebViewPage(
              url: args,
            ),
          );
        }
        return MaterialPageRoute(builder: (_) => MainPage());
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
