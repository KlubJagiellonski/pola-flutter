import 'package:flutter/material.dart';
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
        child: Padding(
          padding: const EdgeInsets.fromLTRB(32.0, 13.0, 32.0, 32.0),
          child: Column(
            children: [
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
                  Navigator.pushNamed(context, '/web',
                      arguments: "https://www.pola-app.pl/m/about");
                },
              ),
              MenuBottomItem(
                text: "O Klubie Jagielońskim",
                iconPath: 'info',
                onClick: () {
                  analytics.aboutOpened(AnalyticsAboutRow.aboutKJ);
                  Navigator.pushNamed(context, '/web',
                      arguments:
                          "https://klubjagiellonski.pl/o-klubie-jagiellonskim/");
                },
              ),
              MenuBottomItem(
                text: "Jak oceniamy Firmy",
                iconPath: 'thumbs',
                onClick: () {
                  analytics.aboutOpened(AnalyticsAboutRow.instructionSet);
                  Navigator.pushNamed(context, '/web',
                      arguments: "https://www.pola-app.pl/m/method");
                },
              ),
              MenuBottomItem(
                text: "Partnerzy",
                iconPath: 'handshake',
                onClick: () {
                  analytics.aboutOpened(AnalyticsAboutRow.partners);
                  Navigator.pushNamed(context, '/web',
                      arguments: "https://www.pola-app.pl/m/partners");
                },
              ),
              MenuBottomItem(
                text: "Przyjaciele Poli",
                iconPath: 'diversity',
                onClick: () {
                  analytics.aboutOpened(AnalyticsAboutRow.polasFriends);
                  Navigator.pushNamed(context, '/web',
                      arguments: "https://www.pola-app.pl/m/friends");
                },
              ),
              MenuBottomItem(
                text: "Oceń Polę",
                iconPath: 'star',
                onClick: () {
                  analytics.aboutOpened(AnalyticsAboutRow.rateUs);
                  throw UnimplementedError(
                      "todo when app in store inAppReview.openStoreListing(appStoreId: '...',);");
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
                  Navigator.pushNamed(context, '/web',
                      arguments: "https://github.com/KlubJagiellonski");
                },
              ),
              const SizedBox(height: 20),
              Container(
                width: 296,
                height: 1,
                color: const Color(0xFFF0F0F0),
              ),
              const SizedBox(height: 20),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Znajdź nas tutaj",
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 10),
// Użycie Row i Expanded dla guzików
              SizedBox(
                height: 60,
                child: Row(
                  mainAxisAlignment:
                      MainAxisAlignment.start, // Umożliwia przesuwanie w lewo
                  children: [
                    Expanded(
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [
                            HorizontalButton(
                              text: "Twitter",
                              onPressed: () {
                                analytics
                                    .aboutOpened(AnalyticsAboutRow.twitter);
                                Navigator.pushNamed(context, '/web',
                                    arguments: "https://twitter.com/pola_app");
                              },
                            ),
                            HorizontalButton(
                              text: "Facebook",
                              onPressed: () {
                                analytics
                                    .aboutOpened(AnalyticsAboutRow.facebook);
                              },
                            ),
                            HorizontalButton(
                              text: "facebook",
                              onPressed: () {
                                analytics
                                    .aboutOpened(AnalyticsAboutRow.facebook);
                              },
                            ),
                            HorizontalButton(
                              text: "facebook",
                              onPressed: () {
                                analytics
                                    .aboutOpened(AnalyticsAboutRow.facebook);
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.all(6.0),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Aplikacja Pola \n©Klub Jagielloński",
                    style: const TextStyle(
                        fontSize: 14, fontWeight: FontWeight.w500),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
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
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10.0),
        child: Row(
          children: [
            Image.asset("assets/icons/$iconPath.png"),
            const SizedBox(width: 10.0),
            Text(text, style: textStyle),
          ],
        ),
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
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
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
