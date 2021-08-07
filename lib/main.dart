import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pola_flutter/pages/home/home.dart';
import 'package:pola_flutter/pages/home/home_bloc.dart';
import 'package:pola_flutter/pages/web.dart';
import 'package:logging/logging.dart';

void main() {
  _setupLogging();
  runApp(PolaApp());
}


class PolaApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return
       MaterialApp(
        title: 'PolaApp',
        theme: ThemeData(
          primarySwatch: Colors.red,
        ),
        initialRoute: '/',
        onGenerateRoute: RouteGenerator.generateRoute,
    );
  }
}

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments;

    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => HomePage());
      case '/web':
        if (args is String) {
          return MaterialPageRoute(
            builder: (_) => WebViewPage(
              url: args,
            ),
          );
        }
        return MaterialPageRoute(builder: (_) => HomePage());
      default:
        return MaterialPageRoute(builder: (_) => HomePage());
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