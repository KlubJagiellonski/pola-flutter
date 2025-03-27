import 'package:flutter/material.dart';
import 'package:pola_flutter/i18n/strings.g.dart';
import 'package:pola_flutter/models/search_result.dart';
import 'package:pola_flutter/pages/detail/detail.dart';
import 'package:pola_flutter/pages/dialpad/dialpad.dart';
import 'package:pola_flutter/pages/scan/scan.dart';
import 'package:pola_flutter/ui/web_view_tab.dart';

class ScanNavigator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Navigator(
      onGenerateRoute: generateRoute,
      initialRoute: '/',
    );
  }

  Route<dynamic> generateRoute(RouteSettings settings) {
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
      case '/search':
      return MaterialPageRoute(
        builder: (context) => WebViewTab(
          title: Translations.of(context).search.title,
           url: "https://www.pola-app.pl/m/search/"
        ));
      default:
        return MaterialPageRoute(builder: (_) => MainPage());
    }
  }
}
