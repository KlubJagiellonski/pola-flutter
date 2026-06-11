import 'package:flutter/material.dart';
import 'package:pola_flutter/models/search_result.dart';
import 'package:pola_flutter/pages/detail/detail.dart';
import 'package:pola_flutter/pages/dialpad/dialpad.dart';
import 'package:pola_flutter/pages/report/report_page.dart';
import 'package:pola_flutter/pages/scan/scan.dart';
<<<<<<< HEAD
import 'package:pola_flutter/ui/web_view_tab.dart';
import 'package:pola_flutter/config/app_urls.dart';
=======
import 'package:pola_flutter/pages/search/search_page.dart';
>>>>>>> 01f81a5 (Refactor Webview Search to Native)

class ScanNavigator extends StatefulWidget {
  final GlobalKey<NavigatorState>? navigatorKey;
  final bool isActive;

  const ScanNavigator({super.key, this.navigatorKey, this.isActive = true});

  @override
  State<ScanNavigator> createState() => _ScanNavigatorState();
}

class _ScanNavigatorState extends State<ScanNavigator> {
  final routeObserver = RouteObserver<ModalRoute<dynamic>>();
  late final ValueNotifier<bool> _scanTabActive;
  bool _rootOverlayPushed = false;

  @override
  void initState() {
    super.initState();
    _scanTabActive = ValueNotifier<bool>(widget.isActive);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final route = ModalRoute.of(context);
    final overlayPushed = route != null && !route.isCurrent;
    if (overlayPushed != _rootOverlayPushed) {
      _rootOverlayPushed = overlayPushed;
      _updateScanTabActive();
    }
  }

  void _updateScanTabActive() {
    _scanTabActive.value = widget.isActive && !_rootOverlayPushed;
  }

  @override
  void didUpdateWidget(ScanNavigator oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.isActive != widget.isActive) {
      _updateScanTabActive();
    }
  }

  @override
  void dispose() {
    _scanTabActive.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: widget.navigatorKey,
      observers: [routeObserver],
      onGenerateRoute: _generateRoute,
      initialRoute: '/',
    );
  }

  Route<dynamic> _generateRoute(RouteSettings settings) {
    final args = settings.arguments;

    switch (settings.name) {
      case '/':
        return MaterialPageRoute(
          builder: (_) => MainPage(
            routeObserver: routeObserver,
            scanTabActive: _scanTabActive,
          ),
        );
      case '/detail':
        if (args is SearchResult) {
          return MaterialPageRoute(
            builder: (_) => DetailPage(searchResult: args),
          );
        }
        return MaterialPageRoute(
          builder: (_) => MainPage(
            routeObserver: routeObserver,
            scanTabActive: _scanTabActive,
          ),
        );
      case '/dialpad':
        return MaterialPageRoute(builder: (_) => DialPadPage());
      case '/search':
<<<<<<< HEAD
        return MaterialPageRoute(
          builder: (context) => WebViewTab(
            title: Translations.of(context).search.title,
            url: AppUrls.search,
          ),
        );
=======
        return MaterialPageRoute(builder: (_) => const SearchPage());
>>>>>>> 01f81a5 (Refactor Webview Search to Native)
      case '/report':
        return MaterialPageRoute(
          builder: (_) => ReportPage(productId: args is int ? args : null),
        );
      default:
        return MaterialPageRoute(
          builder: (_) => MainPage(
            routeObserver: routeObserver,
            scanTabActive: _scanTabActive,
          ),
        );
    }
  }
}
