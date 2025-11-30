import 'package:flutter/material.dart';
import 'package:pola_flutter/analytics/analytics_main_tab.dart';
import 'package:pola_flutter/analytics/pola_analytics.dart';
import 'package:pola_flutter/i18n/strings.g.dart';
import 'package:pola_flutter/pages/scan/scan_navigator.dart';
import 'package:pola_flutter/pages/web/web_view_page.dart';
import 'package:pola_flutter/theme/assets.gen.dart';
import 'package:pola_flutter/ui/web_view_tab.dart';

class PolaTabController extends StatefulWidget {
  @override
  State<PolaTabController> createState() => _PolaTabControllerState();
}

class _PolaTabControllerState extends State<PolaTabController> {
  int _selectedIndex = 0;
  final _analytics = PolaAnalytics.instance();
  final _scanNavigatorKey = GlobalKey<NavigatorState>();
  final _newsWebViewPageKey = GlobalKey<WebViewPageState>();

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        bottomNavigationBar: BottomNavigationBar(
          items: [
            BottomNavigationBarItem(
              icon: _selectedIndex == 0
                  ? Assets.tabs.searchBackground.svg()
                  : Assets.tabs.search.svg(),
              label: t.tabs.search,
            ),
            BottomNavigationBarItem(
              icon: _selectedIndex == 1
                  ? Assets.tabs.newsBackground.svg()
                  : Assets.tabs.news.svg(),
              label: t.tabs.news,
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
    );
  }

  List<Widget> get _tabs => [
        ScanNavigator(navigatorKey: _scanNavigatorKey),
        WebViewTab(
          title: t.news.title,
          url: "https://www.pola-app.pl/m/blog/",
          pageKey: _newsWebViewPageKey,
        )
      ];

  AnalyticsMainTab _getTabParameter(int index) {
    switch (index) {
      case 0:
        return AnalyticsMainTab.scanner;
      case 1:
        return AnalyticsMainTab.news;
      default:
        return AnalyticsMainTab.scanner;
    }
  }

  void _onItemTapped(int index) {
    if (index == _selectedIndex) {
      switch (index) {
        case 0:
          final navigator = _scanNavigatorKey.currentState;
          if (navigator != null && navigator.canPop()) {
            navigator.popUntil((route) => route.isFirst);
          }
          break;

        case 1:
          final webViewPage = _newsWebViewPageKey.currentState;
          if (webViewPage != null) {
            webViewPage.popToRootPage();
          }
          break;
      }
    } else {
      _analytics.mainTabChanged(_getTabParameter(index));
      setState(() {
        _selectedIndex = index;
      });
    }
  }
}
