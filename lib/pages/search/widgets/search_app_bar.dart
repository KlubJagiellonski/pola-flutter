import 'package:flutter/material.dart';
import 'package:pola_flutter/theme/colors.dart';
import 'package:pola_flutter/theme/fonts.gen.dart';
import 'package:pola_flutter/theme/text_size.dart';
import 'package:pola_flutter/ui/menu_icon_button.dart';

class SearchAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;

  const SearchAppBar({super.key, required this.title});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.white,
      elevation: 0,
      leading: BackButton(color: AppColors.text),
      titleSpacing: 0,
      title: Text(
        title,
        style: const TextStyle(
          color: AppColors.text,
          fontSize: TextSize.pageTitle,
          fontFamily: FontFamily.lato,
          fontWeight: FontWeight.w700,
        ),
      ),
      actions: [MenuIconButton(color: AppColors.text)],
    );
  }
}
