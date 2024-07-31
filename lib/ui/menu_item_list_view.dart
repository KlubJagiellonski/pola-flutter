import 'dart:io';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:pola_flutter/analytics/analytics_about_row.dart';
import 'package:pola_flutter/analytics/pola_analytics.dart';

class MenuItemListView extends StatelessWidget {
  final PolaAnalytics analytics;

  const MenuItemListView({super.key, required this.analytics});

 @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _externalUrlItem(
          text: "O aplikacji Pola",
          iconPath: 'info',
          analyticsRow: AnalyticsAboutRow.aboutPola,
          url: 'https://www.pola-app.pl/m/about',
        ),
        _externalUrlItem(
          text: "O Klubie Jagielońskim",
          iconPath: 'info',
          analyticsRow: AnalyticsAboutRow.aboutKJ,
          url: 'https://klubjagiellonski.pl/o-klubie-jagiellonskim/',
        ),
        _externalUrlItem(
          text: "Jak oceniamy Firmy",
          iconPath: 'thumbs',
          analyticsRow: AnalyticsAboutRow.instructionSet,
          url: 'https://www.pola-app.pl/m/method',
        ),
        _externalUrlItem(
          text: "Partnerzy",
          iconPath: 'handshake',
          analyticsRow: AnalyticsAboutRow.partners,
          url: 'https://www.pola-app.pl/m/partners',
        ),
        _externalUrlItem(
          text: "Przyjaciele Poli",
          iconPath: 'diversity',
          analyticsRow: AnalyticsAboutRow.polasFriends,
          url: 'https://www.pola-app.pl/m/friends',
        ),
        _externalUrlItem(
          text: "Oceń Polę",
          iconPath: 'star',
          analyticsRow: AnalyticsAboutRow.rateUs,
          url: Platform.isIOS
              ? "https://apps.apple.com/app/id1038401148"
              : "https://play.google.com/store/apps/details?id=pl.pola_app",
        ),
        _webViewItem(
          context: context,
          text: "Zespół",
          iconPath: 'groups',
          analyticsRow: AnalyticsAboutRow.team,
          url: 'https://www.pola-app.pl/m/team',
        ),
        _externalUrlItem(
          text: "Github",
          iconPath: 'github',
          analyticsRow: AnalyticsAboutRow.github,
          url: 'https://github.com/KlubJagiellonski',
        ),
      ],
    );
  }

  Widget _webViewItem({
    required BuildContext context,
    required String text,
    required String iconPath,
    required AnalyticsAboutRow analyticsRow,
    required String url,
  }) {
    return _MenuBottomItem(
      text: text,
      iconPath: iconPath,
      onClick: () {
        analytics.aboutOpened(analyticsRow);
         Navigator.pushNamed(context, '/web', arguments: url);
      },
    );
  }

  Widget _externalUrlItem({
    required String text,
    required String iconPath,
    required AnalyticsAboutRow analyticsRow,
    required String url,
  }) {
    return _MenuBottomItem(
      text: text,
      iconPath: iconPath,
      onClick: () {
        analytics.aboutOpened(analyticsRow);
        _launchURL(url);
      },
    );
  }
  void _launchURL(String url) async {
    launchUrl(
      Uri.parse(url),
      mode: LaunchMode.externalApplication,
    );
  }
}

class _MenuBottomItem extends StatelessWidget {
  final String text;
  final String iconPath;
  final VoidCallback onClick;

  const _MenuBottomItem({
    required this.text,
    required this.iconPath,
    required this.onClick,
  });

  final textStyle = const TextStyle(
      fontWeight: FontWeight.w500, fontSize: 16.0, fontFamily: 'Lato');

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onClick,
      child: Column(
        children: [
          const SizedBox(height: 16),
          Row(
            children: [
              const SizedBox(width: 32),
              Image.asset("assets/icons/$iconPath.png"),
              const SizedBox(width: 20.0),
              Text(text, style: textStyle),
              const SizedBox(width: 32),
            ],
          ),
        ],
      ),
    );
  }
}
