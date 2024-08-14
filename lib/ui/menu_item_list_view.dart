import 'dart:io';
import 'package:flutter/material.dart';
import 'package:pola_flutter/theme/assets.gen.dart';
import 'package:pola_flutter/theme/fonts.gen.dart';
import 'package:pola_flutter/theme/text_size.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:pola_flutter/analytics/analytics_about_row.dart';
import 'package:pola_flutter/analytics/pola_analytics.dart';
import 'package:pola_flutter/i18n/strings.g.dart';
import 'web_view_dialog.dart';

class MenuItemListView extends StatelessWidget {
  final PolaAnalytics analytics;

  const MenuItemListView({super.key, required this.analytics});

  @override
  Widget build(BuildContext context) {
    final Translations t = Translations.of(context);
    return Column(
      children: [
        _webViewItem(
          context: context,
          text: t.menu.aboutPola,
          icon: Assets.menuPage.info.svg(),
          analyticsRow: AnalyticsAboutRow.aboutPola,
          url: 'https://www.pola-app.pl/m/about',
        ),
        _webViewItem(
          context: context,
          text: t.menu.aboutClub,
          icon: Assets.menuPage.info.svg(),
          analyticsRow: AnalyticsAboutRow.aboutKJ,
          url: 'https://klubjagiellonski.pl/o-klubie-jagiellonskim/',
        ),
        _webViewItem(
          context: context,
          text: t.menu.instruction,
          icon: Assets.menuPage.thumbs.svg(),
          analyticsRow: AnalyticsAboutRow.instructionSet,
          url: 'https://www.pola-app.pl/m/method',
        ),
        _webViewItem(
          context: context,
          text: t.menu.partners,
          icon: Assets.menuPage.handshake.svg(),
          analyticsRow: AnalyticsAboutRow.partners,
          url: 'https://www.pola-app.pl/m/partners',
        ),
        _webViewItem(
          context: context,
          text: t.menu.polasFriends,
          icon: Assets.menuPage.diversity.svg(),
          analyticsRow: AnalyticsAboutRow.polasFriends,
          url: 'https://www.pola-app.pl/m/friends',
        ),
        _externalUrlItem(
          text: t.menu.rateUS,
          icon: Assets.menuPage.star.svg(), 
          analyticsRow: AnalyticsAboutRow.rateUs,
          url: Platform.isIOS
              ? "https://apps.apple.com/app/id1038401148"
              : "https://play.google.com/store/apps/details?id=pl.pola_app",
        ),
        _webViewItem(
          context: context,
          text: t.menu.team,
          icon: Assets.menuPage.groups.svg(),
          analyticsRow: AnalyticsAboutRow.team,
          url: 'https://www.pola-app.pl/m/team',
        ),
        _externalUrlItem(
          text: "Github",
          icon: Assets.menuPage.github.svg(),
          analyticsRow: AnalyticsAboutRow.github,
          url: 'https://github.com/KlubJagiellonski',
        ),
      ],
    );
  }

  Widget _webViewItem({
    required BuildContext context,
    required String text,
    required Widget icon,
    required AnalyticsAboutRow analyticsRow,
    required String url,
  }) {
    return _MenuBottomItem(
      text: text,
      icon: icon,
      onClick: () {
        analytics.aboutOpened(analyticsRow);
        showDialog(
          context: context,
          builder: (context) {
            return WebViewDialog(url: url, title: text);
          },
        );
      },
    );
  }

  Widget _externalUrlItem({
    required String text,
    required Widget icon,
    required AnalyticsAboutRow analyticsRow,
    required String url,
  }) {
    return _MenuBottomItem(
      text: text,
      icon: icon,
      onClick: () {
        analytics.aboutOpened(analyticsRow);
        _launchURL(url);
      },
    );
  }

  void _launchURL(String url) async {
    launchUrl(
      Uri.parse(url),
      mode: LaunchMode.externalApplication,
    );
  }
}

class _MenuBottomItem extends StatelessWidget {
  final String text;
  final Widget icon;
  final VoidCallback onClick;

  const _MenuBottomItem({
    required this.text,
    required this.icon,
    required this.onClick,
  });

  final textStyle = const TextStyle(
      fontWeight: FontWeight.w500, fontSize: TextSize.mediumTitle, fontFamily: FontFamily.lato);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onClick,
      child: Column(
        children: [
          const SizedBox(height: 16),
          Row(
            children: [
              const SizedBox(width: 32),
              icon,
              const SizedBox(width: 20.0),
              Text(text, style: textStyle),
              const SizedBox(width: 32),
            ],
          ),
        ],
      ),
    );
  }
}
