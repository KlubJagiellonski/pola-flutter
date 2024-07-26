import 'package:flutter/material.dart';
import 'package:pola_flutter/analytics/analytics_about_row.dart';
import 'package:pola_flutter/analytics/pola_analytics.dart';
import 'package:url_launcher/url_launcher.dart';

class SocialMediaListview extends StatelessWidget {
  final PolaAnalytics analytics;

  const SocialMediaListview({super.key, required this.analytics});

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
