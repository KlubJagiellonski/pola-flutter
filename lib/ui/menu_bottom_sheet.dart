import 'package:flutter/material.dart';
import 'package:pola_flutter/analytics/analytics_about_row.dart';
import 'package:pola_flutter/analytics/pola_analytics.dart';
import 'package:url_launcher/url_launcher.dart';

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
              _WebViewItem(
                "O aplikacji Pola", 
                analytics, 
                AnalyticsAboutRow.aboutPola,
                "https://www.pola-app.pl/m/about"
              ),
              _WebViewItem(
                "Instrukcja obsługi", 
                analytics, 
                AnalyticsAboutRow.instructionSet,
                "https://www.pola-app.pl/m/method"
              ),
              _WebViewItem(
                "O Klubie Jagiellońskim",
                analytics,
                AnalyticsAboutRow.aboutKJ,
                "https://klubjagiellonski.pl/o-klubie-jagiellonskim/"
              ),
              _WebViewItem(
                "Zespół",
                analytics,
                AnalyticsAboutRow.team,
                "https://www.pola-app.pl/m/team"
              ),
              _WebViewItem(
                "Partnerzy",
                analytics,
                AnalyticsAboutRow.partners,
                "https://www.pola-app.pl/m/partners"
              ),
              _WebViewItem(
                "Przyjaciele Poli",
                analytics,
                AnalyticsAboutRow.polasFriends,
                "https://www.pola-app.pl/m/friends"
              ),
              _ExternalUrlItem(
                "GitHub",
                analytics,
                AnalyticsAboutRow.github,
                "https://github.com/KlubJagiellonski/pola-flutter"
              ),
              MenuBottomItem("Oceń Polę", () {
                analytics.aboutOpened(AnalyticsAboutRow.rateUs);
                throw UnimplementedError(
                    "todo when app in store inAppReview.openStoreListing(appStoreId: '...',);");
              }), //todo
              Row(
                children: [
                  Expanded(
                      child: _ExternalUrlItem(
                          "Facebook",
                          analytics,
                          AnalyticsAboutRow.facebook,
                          "https://www.facebook.com/app.pola"
                        )
                  ),
                  Expanded(
                      child: _ExternalUrlItem(
                          "X",
                          analytics,
                          AnalyticsAboutRow.twitter,
                          "https://twitter.com/pola_app"
                        )
                 )
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

class _ExternalUrlItem extends StatelessWidget {
  _ExternalUrlItem(this.text, this.analytics, this.analyticsRow, this.url);

  final String text;
  final PolaAnalytics analytics;
  final AnalyticsAboutRow analyticsRow;
  final String url;

  @override
  Widget build(BuildContext context) {
    return MenuBottomItem(text, () {
      analytics.aboutOpened(analyticsRow);
      launchUrl(
        Uri.parse(url),
        mode: LaunchMode.externalApplication,
      );
    });
  }
}

class _WebViewItem extends StatelessWidget {
  _WebViewItem(this.text, this.analytics, this.analyticsRow, this.url);

  final String text;
  final PolaAnalytics analytics;
  final AnalyticsAboutRow analyticsRow;
  final String url;

  @override
  Widget build(BuildContext context) {
    return MenuBottomItem(text, () {
      analytics.aboutOpened(analyticsRow);
      Navigator.pushNamed(context, '/web', arguments: url);
    });
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
