import 'package:flutter/material.dart';
 import 'package:pola_flutter/theme/assets.gen.dart';
import 'package:pola_flutter/theme/fonts.gen.dart';
import 'package:pola_flutter/ui/web_view_dialog.dart';

class FriendsBar extends StatelessWidget {
  final String message;
  final String url;

  const FriendsBar({Key? key, required this.message, required this.url})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showDialog(
          context: context,
          builder: (context) {
            return WebViewDialog(url: url, title: "Przyjaciele Poli");
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
              child: Assets.icHeart.svg(height: 13, width: 15)
            ),
            Expanded(
              child: Center(
                child: Text(
                  message,
                   style: TextStyle(
                        fontSize: 16.0,
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
              child: Assets.icHeart.svg(height: 13, width: 15)
            ),
          ],
        ),
      ),
    );
  }
}
