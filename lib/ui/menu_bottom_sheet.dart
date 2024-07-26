import 'package:flutter/material.dart';
import 'package:pola_flutter/analytics/pola_analytics.dart';
import 'package:pola_flutter/ui/social_media_list_view.dart';
import 'menu_item_list_view.dart';

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
            const SizedBox(height: 11),
            MenuItemListview(analytics: analytics),
            const SizedBox(height: 23),
            Container(
              width: 328,
              height: 1,
              color: const Color(0xFFF0F0F0),
            ),
            const SizedBox(height: 17),
            SocialMediaListview(analytics: analytics),
            const SizedBox(height: 33),
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
    return SizedBox(
      height: 40,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          foregroundColor: const Color(0xFFE1203E),
          backgroundColor: const Color(0xFFF5DEDD),
          textStyle: const TextStyle(fontFamily: 'Roboto'),
        ),
        onPressed: onPressed,
        child: Text(text),
      ),
    );
  }
}
