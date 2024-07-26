import 'dart:io';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:pola_flutter/analytics/analytics_about_row.dart';
import 'package:pola_flutter/analytics/pola_analytics.dart';

class MenuBottomItem extends StatelessWidget {
  final String text;
  final String iconPath;
  final VoidCallback onClick;

  const MenuBottomItem({
    super.key,
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

class MenuBottomItems extends StatelessWidget {
  final PolaAnalytics analytics;

  const MenuBottomItems({super.key, required this.analytics});

  void _launchURL(String url) async {
    launchUrl(
      Uri.parse(url),
      mode: LaunchMode.externalApplication,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        MenuBottomItem(
          text: "O aplikacji Pola",
          iconPath: 'info',
          onClick: () {
            analytics.aboutOpened(AnalyticsAboutRow.aboutPola);
            _launchURL('https://www.pola-app.pl/m/about');
          },
        ),
        MenuBottomItem(
          text: "O Klubie Jagielońskim",
          iconPath: 'info',
          onClick: () {
            analytics.aboutOpened(AnalyticsAboutRow.aboutKJ);
            _launchURL('https://klubjagiellonski.pl/o-klubie-jagiellonskim/');
          },
        ),
        MenuBottomItem(
          text: "Jak oceniamy Firmy",
          iconPath: 'thumbs',
          onClick: () {
            analytics.aboutOpened(AnalyticsAboutRow.instructionSet);
            _launchURL('https://www.pola-app.pl/m/method');
          },
        ),
        MenuBottomItem(
          text: "Partnerzy",
          iconPath: 'handshake',
          onClick: () {
            analytics.aboutOpened(AnalyticsAboutRow.partners);
            _launchURL('https://www.pola-app.pl/m/partners');
          },
        ),
        MenuBottomItem(
          text: "Przyjaciele Poli",
          iconPath: 'diversity',
          onClick: () {
            analytics.aboutOpened(AnalyticsAboutRow.polasFriends);
            _launchURL('https://www.pola-app.pl/m/friends');
          },
        ),
        MenuBottomItem(
          text: "Oceń Polę",
          iconPath: 'star',
          onClick: () {
            analytics.aboutOpened(AnalyticsAboutRow.rateUs);
            final url = Platform.isIOS
                ? "https://apps.apple.com/app/id1038401148"
                : "https://play.google.com/store/apps/details?id=pl.pola_app";
            _launchURL(url);
          },
        ),
        MenuBottomItem(
          text: "Zespół",
          iconPath: 'groups',
          onClick: () {
            analytics.aboutOpened(AnalyticsAboutRow.team);
            Navigator.pushNamed(context, '/web',
                arguments: "https://www.pola-app.pl/m/team");
          },
        ),
        MenuBottomItem(
          text: "Github",
          iconPath: 'github',
          onClick: () {
            analytics.aboutOpened(AnalyticsAboutRow.github);
            _launchURL('https://github.com/KlubJagiellonski');
          },
        ),
      ],
    );
  }
}
