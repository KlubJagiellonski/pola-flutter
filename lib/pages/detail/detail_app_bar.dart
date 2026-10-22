import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:pola_flutter/theme/colors.dart';
import 'package:pola_flutter/theme/text_size.dart';
import 'package:pola_flutter/ui/menu_icon_button.dart';

AppBar buildDetailAppBar(
  BuildContext context, {
  required String title,
  required double availableWidth,
  bool showMenu = true,
}) {
  const titleSpacing = 16.0;
  const buttonWidth = kToolbarHeight;
  final style = Theme.of(context).textTheme.titleLarge!.copyWith(
    color: AppColors.text,
    fontSize: TextSize.newsTitle,
    fontWeight: FontWeight.w600,
  );
  final titleWidth = math.max(
    1.0,
    availableWidth -
        MediaQuery.paddingOf(context).horizontal -
        buttonWidth -
        (showMenu ? buttonWidth : 0) -
        2 * titleSpacing,
  );
  final painter = TextPainter(
    text: TextSpan(text: title, style: style),
    textDirection: Directionality.of(context),
    textScaler: MediaQuery.textScalerOf(context),
    locale: Localizations.maybeLocaleOf(context),
  )..layout(maxWidth: titleWidth);
  final toolbarHeight = math.max(kToolbarHeight, painter.height + 16);
  painter.dispose();

  return AppBar(
    centerTitle: false,
    toolbarHeight: toolbarHeight,
    leadingWidth: buttonWidth,
    titleSpacing: titleSpacing,
    titleTextStyle: style,
    title: Text(
      title,
      textScaler: MediaQuery.textScalerOf(context),
      softWrap: true,
      overflow: TextOverflow.visible,
    ),
    leading: BackButton(color: AppColors.text),
    actionsPadding: EdgeInsets.zero,
    actions: showMenu
        ? [
            SizedBox(
              width: buttonWidth,
              child: MenuIconButton(color: AppColors.text),
            ),
          ]
        : null,
  );
}
