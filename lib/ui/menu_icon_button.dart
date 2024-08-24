import 'package:flutter/material.dart';
import 'package:pola_flutter/analytics/analytics_about_row.dart';
import 'package:pola_flutter/analytics/pola_analytics.dart';
import 'package:pola_flutter/pages/menu/menu_bottom_sheet.dart';
import 'package:pola_flutter/theme/assets.gen.dart';
import 'package:pola_flutter/theme/colors.dart';

class MenuIconButton extends StatelessWidget {
  final PolaAnalytics _analytics = PolaAnalytics.instance();

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        _analytics.aboutOpened(AnalyticsAboutRow.menu);
        showModalBottomSheet<void>(
          backgroundColor: Colors.transparent,
          isScrollControlled: true,
          context: context,
          builder: (BuildContext context) {
            return MenuBottomSheet(analytics: _analytics);
          }
        );
      },
      icon: Assets.menuPage.menu.svg(
        colorFilter: ColorFilter.mode(AppColors.textColor, BlendMode.srcIn)
        ),
    );
  }
}
