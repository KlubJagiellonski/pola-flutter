import 'package:flutter/material.dart';
import 'package:pola_flutter/analytics/pola_analytics.dart';
import 'package:pola_flutter/theme/colors.dart';
import 'package:pola_flutter/theme/fonts.gen.dart';
import 'package:pola_flutter/theme/text_size.dart';
import 'package:pola_flutter/ui/social_media_list_view.dart';
import 'package:pola_flutter/ui/version_widget.dart';
import 'menu_item_list_view.dart';
import 'package:pola_flutter/i18n/strings.g.dart';

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
            MenuItemListView(analytics: analytics),
            const SizedBox(height: 23),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32.0),
              child: Container(
                height: 1,
                color: AppColors.dividerColor,
              ),
            ),
            const SizedBox(height: 17),
            SocialMediaListView(analytics: analytics),
            const SizedBox(height: 17.0),
            MenuFooter(),
            const SizedBox(height: 33),
          ],
        ),
      ),
    );
  }
}

class MenuFooter extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32.0),
      child: Row(
        children: [
          Text(
            t.menu.footer,
            style: TextStyle(
                fontSize: TextSize.smallTitle,
                fontWeight: FontWeight.w600,
                fontFamily: FontFamily.lato),
          ),
          Expanded(child: Container()),
          VersionWidget(),
        ],
      )
    );
  }
}
