import 'dart:io';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:pola_flutter/analytics/analytics_about_row.dart';
import 'package:pola_flutter/analytics/pola_analytics.dart';

class MenuBottomSheet extends StatelessWidget {
  final PolaAnalytics analytics;

  const MenuBottomSheet({super.key, required this.analytics});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(10.0),
            topRight: Radius.circular(10.0),
          ),
          color: Colors.white,
        ),
        child: Column(
          children: [
            const SizedBox(height: 13),
            Container(
              width: 47,
              height: 3,
              decoration: const BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.all(Radius.circular(1.5)),
              ),
            ),
            const SizedBox(height: 27),
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
            const SizedBox(height: 20),
            Container(
              width: 296 + 32, // 296 + 32 (left padding) + 32 (right padding)
              height: 1,
              color: const Color(0xFFF0F0F0),
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                const SizedBox(width: 32.0),
                Text(
                  "Znajdź nas tutaj",
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            SizedBox(
              height: 60,
              child: Row(
                children: [
                  const SizedBox(width: 32.0),
                  Expanded(
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      clipBehavior: Clip.none,
                      child: Row(
                        children: [
                          HorizontalButton(
                            text: "Twitter",
                            onPressed: () {
                              analytics.aboutOpened(AnalyticsAboutRow.twitter);
                              _launchURL('https://twitter.com/pola_app');
                            },
                          ),
                          const SizedBox(width: 14.0),
                          HorizontalButton(
                            text: "Facebook",
                            onPressed: () {
                              analytics.aboutOpened(AnalyticsAboutRow.facebook);
                              _launchURL('https://facebook.com');
                            },
                          ),
                          const SizedBox(width: 14.0), 
                          HorizontalButton(
                            text: "Facebook",
                            onPressed: () {
                              analytics.aboutOpened(AnalyticsAboutRow.facebook);
                              _launchURL('https://facebook.com');
                            },
                          ),
                          const SizedBox(width: 14.0),
                          HorizontalButton(
                            text: "Facebook",
                            onPressed: () {
                              analytics.aboutOpened(AnalyticsAboutRow.facebook);
                              _launchURL('https://facebook.com');
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12.0 ),
            Row(
              children: [
                const SizedBox(width: 32.0),
                Text(
                  "Aplikacja Pola \n© Klub Jagielloński",
                  style: const TextStyle(
                      fontSize: 14, fontWeight: FontWeight.w600),
                ),
              ],
            ),
            const SizedBox(height: 33),
          ],
        ),
      ),
    );
  }

  void _launchURL(String url) async {
    launchUrl(
      Uri.parse(url),
      mode: LaunchMode.externalApplication,
    );
  }
}

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

  final textStyle =
      const TextStyle(fontWeight: FontWeight.w600, fontSize: 16.0);

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

class HorizontalButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;

  const HorizontalButton({
    super.key,
    required this.text,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          foregroundColor: const Color(0xFFE1203E),
          backgroundColor: const Color(0xFFF5DEDD),
        ),
        onPressed: onPressed,
        child: Text(text),
      ),
    );
  }
}
