import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
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
              child: SvgPicture.asset(
                'assets/favorite.svg',
                height: 13.0,
                width: 15.0,
              ),
            ),
            Expanded(
              child: Center(
                child: Text(
                  message,
                  style: TextStyle(
                    fontSize: 12.0,
                    fontWeight: FontWeight.bold,
                    color: const Color(0xFFE1203E),
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 9.0),
              child: SvgPicture.asset(
                'assets/favorite.svg',
                height: 13.0,
                width: 15.0,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
