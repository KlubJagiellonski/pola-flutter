import 'package:flutter/material.dart';

class MenuBottomSheet extends StatelessWidget {
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
                padding: EdgeInsets.all(6.0),
                child: Divider(
                    height: 2,
                    thickness: 1,
                    color: Colors.black.withOpacity(0.4)),
              ),
              MenuBottomItem("O aplikacji Pola", () {
                Navigator.pushNamed(context, '/web',
                    arguments: "https://www.pola-app.pl/m/about");
              }),
              MenuBottomItem("Instrukcja obsługi", () {
                Navigator.pushNamed(context, '/web',
                    arguments: "https://www.pola-app.pl/m/method");
              }),
              MenuBottomItem("O Klubie Jagiellońskim", () {
                Navigator.pushNamed(context, '/web',
                    arguments: "https://klubjagiellonski.pl/o-klubie-jagiellonskim/");
              }),
              MenuBottomItem("Zespół", () {
                Navigator.pushNamed(context, '/web',
                    arguments: "https://www.pola-app.pl/m/team");
              }),
              MenuBottomItem("Partnerzy ", () {
                Navigator.pushNamed(context, '/web',
                    arguments: "https://www.pola-app.pl/m/partners");
              }),
              MenuBottomItem("Przyjaciele Poli ", () {
                Navigator.pushNamed(context, '/web',
                    arguments: "https://www.pola-app.pl/m/friends");
              }),
              MenuBottomItem("Github", () {
                Navigator.pushNamed(context, '/web',
                    arguments:
                        "https://github.com/KlubJagiellonski");
              }),
              MenuBottomItem("Oceń Polę", () {
                throw UnimplementedError(
                    "todo when app in store inAppReview.openStoreListing(appStoreId: '...',);");
              }), //todo
              Row(
                children: [
                  Expanded(
                      child: MenuBottomItem("Facebook", () {
                    Navigator.pushNamed(context, '/web',
                        arguments: "https://www.facebook.com/app.pola");
                  })),
                  Expanded(
                      child: MenuBottomItem(
                    "Twitter",
                    () {
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
                    child: Text(
                        "Aplikacja Pola\nwersja pre-alpha \n©Klub Jagielloński"),
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

  String text;
  Function onClick;

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
            BoxShadow(color: Colors.black54, spreadRadius: 1),
          ],
        ),
        child: GestureDetector(
          onTap: () {
            onClick.call();
          },
          child: Padding(padding: EdgeInsets.all(10.0), child: Text(text)),
        ),
      ),
    );
  }
}
