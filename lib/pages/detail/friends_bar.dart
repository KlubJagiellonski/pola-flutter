import 'package:flutter/material.dart';
 import 'package:pola_flutter/theme/assets.gen.dart';
import 'package:pola_flutter/theme/colors.dart';
import 'package:pola_flutter/theme/fonts.gen.dart';
import 'package:pola_flutter/theme/text_size.dart';
import 'package:pola_flutter/ui/web_view_dialog.dart';
import 'package:pola_flutter/i18n/strings.g.dart';

class FriendsBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Translations t = Translations.of(context);

    return GestureDetector(
      onTap: () {
        showWebViewDialog(
          context: context,
          url: "https://www.pola-app.pl/m/friends",
          title: t.companyScreen.polaFriends
        );
      },
      child: Container(
        height: 40.0,
        color:  AppColors.buttonBackground,
        alignment: Alignment.center,
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 19.0),
              child: Assets.company.heart.svg()
            ),
            Expanded(
              child: Center(
                child: Text(
                 t.companyScreen.companyFriend,
                   style: TextStyle(
                        fontSize: TextSize.smallTitle,
                        fontWeight: FontWeight.w700,
                        fontFamily: FontFamily.lato,
                        color:AppColors.defaultRed,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 19.0),
              child: Assets.company.heart.svg()
            ),
          ],
        ),
      ),
    );
  }
}
