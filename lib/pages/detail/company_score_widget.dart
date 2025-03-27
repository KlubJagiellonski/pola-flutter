import 'package:flutter/material.dart';
import 'package:pola_flutter/i18n/strings.g.dart';
import 'package:pola_flutter/theme/assets.gen.dart';
import 'package:pola_flutter/theme/colors.dart';
import 'package:pola_flutter/theme/fonts.gen.dart';
import 'package:pola_flutter/theme/text_size.dart';
import 'polish_capital_graph.dart';

class CompanyScoreData {
  final double plCapital;
  final bool plWorkers;
  final bool plRnD;
  final bool plRegistered;
  final bool plNotGlobEnt;
  final int plScore;

  CompanyScoreData(
      {required this.plCapital,
      required this.plWorkers,
      required this.plRnD,
      required this.plRegistered,
      required this.plNotGlobEnt,
      required this.plScore});
}

class CompanyScoreWidget extends StatelessWidget {
  final CompanyScoreData data;

  const CompanyScoreWidget({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    final Translations t = Translations.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: Row(
            children: [
              Assets.company.info.svg(height: 24.0, width: 24.0),
              const SizedBox(width: 8.0),
              Text(
                t.companyScreen.ourRating,
                style: TextStyle(
                  fontSize: TextSize.mediumTitle,
                  fontWeight: FontWeight.w600,
                  fontFamily: FontFamily.lato,
                  color: AppColors.text,
                ),
              ),
              const SizedBox(width: 8.0),
              Text(
                t.companyScreen.points(score: data.plScore),
                style: TextStyle(
                  fontSize: TextSize.newsTitle,
                  fontWeight: FontWeight.w700,
                  fontFamily: FontFamily.lato,
                  color: AppColors.text,
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: ClipRRect(
              borderRadius: BorderRadius.circular(10.0),
              child: TweenAnimationBuilder(
                  duration: Duration(milliseconds: data.plScore * 10),
                  tween: Tween<double>(begin: 0, end: data.plScore.toDouble()),
                  builder: (_, double score, __) {
                    return LinearProgressIndicator(
                      value: score / 100.0,
                      backgroundColor: AppColors.buttonBackground,
                      valueColor: const AlwaysStoppedAnimation<Color>(
                          AppColors.defaultRed),
                      minHeight: 12.0,
                    );
                  })),
        ),
        const SizedBox(height: 17.0),
        Divider(
          thickness: 1.0,
          color: AppColors.divider,
          indent: 0,
          endIndent: 0,
        ),
        Padding(
          padding: const EdgeInsets.only(top: 22.0),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              t.companyScreen.gradingCriteria,
              style: TextStyle(
                fontSize: TextSize.mediumTitle,
                fontWeight: FontWeight.w600,
                fontFamily: FontFamily.lato,
                color: AppColors.text,
              ),
            ),
          ),
        ),
        const SizedBox(height: 22.0),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            PolishCapitalGraph(percentage: data.plCapital),
            const SizedBox(width: 35.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _DetailItem(t.companyScreen.producedInPoland, data.plWorkers),
                  const SizedBox(height: 14.0),
                  _DetailItem(t.companyScreen.researchInPoland, data.plRnD),
                  const SizedBox(height: 14.0),
                  _DetailItem(
                      t.companyScreen.registeredInPoland, data.plRegistered),
                  const SizedBox(height: 14.0),
                  _DetailItem(
                      t.companyScreen.notConcernPart, data.plNotGlobEnt),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 22.0),
        Divider(
          thickness: 1.0,
          color: AppColors.divider,
          indent: 0,
          endIndent: 0,
        ),
      ],
    );
  }
}

class _DetailItem extends StatelessWidget {
  const _DetailItem(this.text, this.state, {Key? key}) : super(key: key);

  final String text;
  final bool state;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Padding(
            padding: const EdgeInsets.only(right: 3.0),
            child: state
                ? Assets.company.taskAlt.svg()
                : Assets.company.radioButtonUnchecked.svg()),
        Expanded(
          child: Text(
            text,
            style: TextStyle(
              fontSize: TextSize.description,
              fontWeight: FontWeight.w400,
              fontFamily: FontFamily.lato,
              color: AppColors.text,
            ),
            softWrap: true,
            overflow: TextOverflow.visible,
          ),
        ),
      ],
    );
  }
}
