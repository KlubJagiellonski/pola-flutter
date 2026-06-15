import 'package:flutter/material.dart';
import 'package:pola_flutter/i18n/strings.g.dart';
import 'package:pola_flutter/theme/colors.dart';
import 'package:pola_flutter/theme/fonts.gen.dart';
import 'package:pola_flutter/theme/text_size.dart';

class ScoreBadge extends StatelessWidget {
  final int? score;
  final double width;
  final double minHeight;

  const ScoreBadge({
    super.key,
    required this.score,
    required this.width,
    required this.minHeight,
  });

  @override
  Widget build(BuildContext context) {
    final compact = minHeight <= 44;

    return SizedBox(
      width: width,
      child: ConstrainedBox(
        constraints: BoxConstraints(minHeight: minHeight),
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: AppColors.defaultRed,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(minHeight / 2),
              bottomLeft: Radius.circular(minHeight / 2),
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                score?.toString() ?? '-',
                style: TextStyle(
                  height: compact ? 0 : 1,
                  fontWeight: FontWeight.w700,
                  fontFamily: FontFamily.roboto,
                  fontSize: compact ? TextSize.mediumTitle : TextSize.newsTitle,
                  color: AppColors.white,
                ),
                textAlign: TextAlign.center,
              ),
              Text(
                t.scan.pkt,
                style: TextStyle(
                  height: compact ? 0.1 : 1.1,
                  fontWeight: FontWeight.w700,
                  fontFamily: FontFamily.roboto,
                  fontSize: compact ? 9 : 10,
                  color: AppColors.white,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
