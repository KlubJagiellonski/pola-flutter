import 'package:flutter/material.dart';
 import 'package:pola_flutter/theme/assets.gen.dart';
import 'package:pola_flutter/theme/fonts.gen.dart';
import 'package:pola_flutter/ui/web_view_dialog.dart';
import 'package:pola_flutter/i18n/strings.g.dart';

class FriendsBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Translations t = Translations.of(context);

    return GestureDetector(
      onTap: () {
        showDialog(
          context: context,
          builder: (context) {
            return WebViewDialog(
              url: "https://www.pola-app.pl/m/friends", 
              title: t.companyScreen.polaFriends 
              );
          },
        );
      },
      child: Container(
        height: 40.0,
        color: const Color(0xFFF5DEDD),
        alignment: Alignment.center,
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 9.0),
              child: Assets.favorite.svg(height: 13, width: 15)
            ),
            Expanded(
              child: Center(
                child: Text(
                 t.companyScreen.companyFriend,
                   style: TextStyle(
                        fontSize: 12.0,
                        fontWeight: FontWeight.w700,
                        fontFamily: FontFamily.lato,
                        color: Color(0xFFE1203E),
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 9.0),
              child: Assets.favorite.svg(height: 13, width: 15)
            ),
          ],
        ),
      ),
    );
  }
}
