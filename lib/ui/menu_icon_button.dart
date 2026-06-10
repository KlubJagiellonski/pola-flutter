import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pola_flutter/analytics/analytics_about_row.dart';
import 'package:pola_flutter/analytics/pola_analytics.dart';
import 'package:pola_flutter/pages/menu/menu_bottom_sheet.dart';
import 'package:pola_flutter/theme/assets.gen.dart';

class MenuIconButton extends StatelessWidget {
  final Color color;

  const MenuIconButton({super.key, required this.color});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        final analytics = context.read<PolaAnalytics>();
        analytics.aboutOpened(AnalyticsAboutRow.menu);
        showModalBottomSheet<void>(
          backgroundColor: Colors.transparent,
          isScrollControlled: true,
          context: context,
          useRootNavigator: true,
          builder: (BuildContext context) {
            return MenuBottomSheet(analytics: analytics);
          },
        );
      },
      icon: Assets.menuPage.menu.svg(
        colorFilter: ColorFilter.mode(color, BlendMode.srcIn),
      ),
    );
  }
}
