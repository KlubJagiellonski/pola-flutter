import 'package:flutter/material.dart';
import 'package:pola_flutter/analytics/analytics_about_row.dart';
import 'package:pola_flutter/analytics/pola_analytics.dart';
import 'package:url_launcher/url_launcher.dart';
import 'menu_bottom_item.dart';

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
            MenuBottomItems(analytics: analytics),
            const SizedBox(height: 23),
            Container(
              width: 328,
              height: 1,
              color: const Color(0xFFF0F0F0),
            ),
            const SizedBox(height: 17),
            SocialMediaSection(analytics: analytics),
            const SizedBox(height: 33),
          ],
        ),
      ),
    );
  }
}

class SocialMediaSection extends StatelessWidget {
  final PolaAnalytics analytics;

  const SocialMediaSection({super.key, required this.analytics});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            const SizedBox(width: 32.0),
            const Text(
              "Znajdź nas tutaj",
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w700,
                fontFamily: 'Lato',
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
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 17.0),
        Row(
          children: [
            const SizedBox(width: 32.0),
            const Text(
              "Aplikacja Pola \n© Klub Jagielloński",
              style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  fontFamily: 'Lato'),
            ),
          ],
        ),
      ],
    );
  }

  void _launchURL(String url) async {
    launchUrl(
      Uri.parse(url),
      mode: LaunchMode.externalApplication,
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
