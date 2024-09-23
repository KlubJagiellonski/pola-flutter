import 'package:flutter/material.dart';
import 'package:pola_flutter/theme/assets.gen.dart';
import 'package:pola_flutter/theme/colors.dart';
import 'package:pola_flutter/theme/fonts.gen.dart';
import 'package:pola_flutter/theme/text_size.dart';
import 'package:pola_flutter/i18n/strings.g.dart';

class NoScoreMessage extends StatelessWidget {
   

  @override
  Widget build(BuildContext context) {
    final Translations t = Translations.of(context); 
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 22.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Assets.company.unpublished.svg(height: 109.42, width: 109.55),
          ),
          const SizedBox(height: 26.0),
          Text(
            t.companyScreen.companyUnverified,
            style: TextStyle(
              fontSize: TextSize.description,
              fontWeight: FontWeight.w400,
              fontFamily: FontFamily.lato,
              color: AppColors.text,
            ),
            textAlign: TextAlign.left,
          ),
          Text(
            t.companyScreen.thankYou,
            style: TextStyle(
              fontSize: TextSize.description,
              fontWeight: FontWeight.w700,
              fontFamily: FontFamily.lato,
              color: AppColors.text,
            ),
            textAlign: TextAlign.left,
          )
        ],
      ),
    );
  }
}