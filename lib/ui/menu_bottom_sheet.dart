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
          borderRadius: new BorderRadius.only(
              topLeft: const Radius.circular(10.0),
              topRight: const Radius.circular(10.0)),
          color: Colors.white,
        ),
        child: Padding(
          padding:
              EdgeInsets.only(left: 8.0, top: 8.0, right: 8.0, bottom: 8.0),
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.only(
                    left: 64.0, top: 8.0, right: 64.0, bottom: 8.0),
                child: Divider(
                    height: 1,
                    thickness: 1,
                    indent: 64,
                    endIndent: 64,
                    color: Colors.black),
              ),
              MenuBottomItem("O aplikacji Pola", () {
                analytics.aboutOpened(AnalyticsAboutRow.aboutPola);
                Navigator.pushNamed(context, '/web',
                    arguments: "https://www.pola-app.pl/m/about");
              }),
              MenuBottomItem("Instrukcja obsługi", () {
                analytics.aboutOpened(AnalyticsAboutRow.instructionSet);
                Navigator.pushNamed(context, '/web',
                    arguments: "https://www.pola-app.pl/m/method");
              }),
              MenuBottomItem("O Klubie Jagiellońskim", () {
                analytics.aboutOpened(AnalyticsAboutRow.aboutKJ);
                Navigator.pushNamed(context, '/web',
                    arguments:
                        "https://klubjagiellonski.pl/o-klubie-jagiellonskim/");
              }),
              MenuBottomItem("Zespół", () {
                analytics.aboutOpened(AnalyticsAboutRow.team);
                Navigator.pushNamed(context, '/web',
                    arguments: "https://www.pola-app.pl/m/team");
              }),
              MenuBottomItem("Partnerzy ", () {
                analytics.aboutOpened(AnalyticsAboutRow.partners);
                Navigator.pushNamed(context, '/web',
                    arguments: "https://www.pola-app.pl/m/partners");
              }),
              MenuBottomItem("Przyjaciele Poli ", () {
                analytics.aboutOpened(AnalyticsAboutRow.polasFriends);
                Navigator.pushNamed(context, '/web',
                    arguments: "https://www.pola-app.pl/m/friends");
              }),
              MenuBottomItem("Github", () {
                analytics.aboutOpened(AnalyticsAboutRow.github);
                Navigator.pushNamed(context, '/web',
                    arguments: "https://github.com/KlubJagiellonski");
              }),
              MenuBottomItem("Oceń Polę", () {
                analytics.aboutOpened(AnalyticsAboutRow.rateUs);
                throw UnimplementedError(
                    "todo when app in store inAppReview.openStoreListing(appStoreId: '...',);");
              }), //todo
              Row(
                children: [
                  Expanded(
                      child: MenuBottomItem("Facebook", () {
                    analytics.aboutOpened(AnalyticsAboutRow.facebook);
                    Navigator.pushNamed(context, '/web',
                        arguments: "https://www.facebook.com/app.pola");
                  })),
                  Expanded(
                      child: MenuBottomItem(
                    "Twitter",
                    () {
                      analytics.aboutOpened(AnalyticsAboutRow.twitter);
                      Navigator.pushNamed(context, '/web',
                          arguments: "https://twitter.com/pola_app");
                    },
                  ))
                ],
              ),
              Padding(
                  padding: EdgeInsets.all(6.0),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text("Aplikacja Pola \n©Klub Jagielloński"),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}

class MenuBottomItem extends StatelessWidget {
  MenuBottomItem(this.text, this.onClick);

  final String text;
  final Function onClick;

  final textStyle = TextStyle(fontWeight: FontWeight.w600);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: Container(
        width: double.infinity,
        // color: Colors.transparent,
        decoration: new BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(4.0)),
          color: Colors.white,
          boxShadow: [
            BoxShadow(color: Colors.black12, spreadRadius: 1),
          ],
        ),
        child: GestureDetector(
          onTap: () {
            onClick.call();
          },
          child: Padding(
              padding: EdgeInsets.all(10.0),
              child: Text(text, style: textStyle)),
        ),
      ),
    );
  }
}
