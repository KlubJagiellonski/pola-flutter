import 'package:flutter/material.dart';
import 'package:pola_flutter/i18n/strings.g.dart';
import 'package:pola_flutter/theme/colors.dart';
import 'package:pola_flutter/theme/fonts.gen.dart';
import 'package:pola_flutter/theme/text_size.dart';

class ReportSuccessView extends StatelessWidget {
  final Translations t;

  const ReportSuccessView({super.key, required this.t});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const Icon(
          Icons.check_circle_outline,
          color: AppColors.defaultRed,
          size: 72.0,
        ),
        const SizedBox(height: 24.0),
        Text(
          t.reportScreen.successTitle,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: TextSize.pageTitle,
            fontWeight: FontWeight.w700,
            fontFamily: FontFamily.lato,
            color: AppColors.text,
          ),
        ),
        const SizedBox(height: 12.0),
        Text(
          t.reportScreen.successMessage,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: TextSize.mediumTitle,
            fontFamily: FontFamily.lato,
            color: AppColors.text,
          ),
        ),
      ],
    );
  }
}
