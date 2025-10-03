import 'package:flutter/material.dart';
import 'package:pola_flutter/analytics/analytics_about_row.dart';
import 'package:pola_flutter/analytics/pola_analytics.dart';
import 'package:pola_flutter/theme/colors.dart';
import 'package:pola_flutter/theme/fonts.gen.dart';
import 'package:pola_flutter/theme/text_size.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:pola_flutter/i18n/strings.g.dart';

class SocialMediaListView extends StatelessWidget {
  final PolaAnalytics analytics;

  const SocialMediaListView({super.key, required this.analytics});

  @override
  Widget build(BuildContext context) {
    final Translations t = Translations.of(context);
    return Column(
      children: [
        Row(
          children: [
            SizedBox(width: 32.0),
            Text(
              t.menu.findUs,
              style: TextStyle(
                fontSize: TextSize.smallTitle,
                fontWeight: FontWeight.w700,
                fontFamily: FontFamily.lato
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32.0),
          child: Row(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  clipBehavior: Clip.none,
                  child: Row(
                    children: [
                      _socialItem(
                        text: "Twitter",
                        analyticsRow: AnalyticsAboutRow.twitter,
                        url: 'https://twitter.com/pola_app',
                      ),
                      const SizedBox(width: 14.0),
                      _socialItem(
                        text: "Facebook",
                        analyticsRow: AnalyticsAboutRow.facebook,
                        url: 'https://facebook.com',
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _socialItem({
    required String text,
    required AnalyticsAboutRow analyticsRow,
    required String url,
  }) {
    return SocialItemView(
      text: text,
      onPressed: () {
        analytics.aboutOpened(analyticsRow);
        _launchURL(url);
      },
    );
  }

  void _launchURL(String url) async {
    await launchUrl(
      Uri.parse(url),
      mode: LaunchMode.externalApplication,
    );
  }
}

class SocialItemView extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;

  const SocialItemView({
    super.key,
    required this.text,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          foregroundColor: AppColors.defaultRed,
          backgroundColor: AppColors.buttonBackground,
          textStyle: const TextStyle(fontFamily: FontFamily.roboto),
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
        ),
        onPressed: onPressed,
        child: Text(text),
      ),
    );
  }
}
