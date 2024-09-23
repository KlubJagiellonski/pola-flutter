import 'package:flutter/material.dart';
import 'package:pola_flutter/models/company.dart';
import 'package:pola_flutter/models/search_result.dart';
import 'package:pola_flutter/i18n/strings.g.dart';
import 'package:pola_flutter/theme/assets.gen.dart';
import 'package:pola_flutter/theme/colors.dart';
import 'package:pola_flutter/theme/fonts.gen.dart';
import 'package:pola_flutter/theme/text_size.dart';
import 'company_score_widget.dart';
import 'expandandable_text.dart';
import 'logotypes.dart';
import 'polish_capital_graph.dart';
import 'friends_bar.dart';

class DetailContent extends StatelessWidget {
  const DetailContent(this.searchResult, {Key? key}) : super(key: key);

  final SearchResult searchResult;

  @override
  Widget build(BuildContext context) {
    if (searchResult.companies == null || searchResult.companies!.isEmpty) {
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(searchResult.altText ?? ""),
      );
    }

    final company = searchResult.companies!.first;
    final score = company.plScore ?? 0;
    final double plCapital = (company.plCapital ?? 0).toDouble();
    final Translations t = Translations.of(context);

    final hasLogo = company.logotypeUrl != null;
    final hasDescription = company.description?.isNotEmpty ?? false;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if ((company.isFriend ?? false)) FriendsBar(),
        const SizedBox(height: 20.0),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 17.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _ScoreSection(company: company),
              if (hasDescription) ...[
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 22.0),
                  child: ExpandableText(company.description ?? ""),
                ),
                if (hasLogo)
                  Divider(
                    thickness: 1.0,
                    color: AppColors.divider,
                    indent: 0,
                    endIndent: 0,
                  ),
              ],
              if (hasLogo)
                Logotypes(
                    logotypes: searchResult.logotypes(),
                    searchResult: searchResult),
              const SizedBox(height: 26.0),
              if (hasLogo)
                Divider(
                  thickness: 1.0,
                  color: AppColors.divider,
                  indent: 0,
                  endIndent: 0,
                ),
            ],
          ),
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
              : Assets.company.radioButtonUnchecked.svg(),
        ),
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

extension on SearchResult {
  List<Logotype> logotypes() {
    var brandLogotypes = allCompanyBrands?.map((brand) {
          final brandLogotype = brand.logotypeUrl;
          if (brandLogotype != null) {
            return Logotype(brandLogotype, null);
          } else {
            return null;
          }
        }).toList() ??
        [];

    final logotypeCompany = companies?.first.logotype();

    brandLogotypes.insert(0, logotypeCompany);

    return brandLogotypes
        .where((logotype) => logotype != null)
        .cast<Logotype>()
        .toList();
  }
}

extension on Company {
  Logotype? logotype() {
    final logotypeUrl = this.logotypeUrl;
    if (logotypeUrl != null) {
      return Logotype(logotypeUrl, officialUrl);
    } else {
      return null;
    }
  }

  CompanyScoreData? scoreData() {
    final int? plCapital = this.plCapital;
    final int? plWorkers = this.plWorkers;
    final int? plRnD = this.plRnD;
    final int? plRegistered = this.plRegistered;
    final int? plNotGlobEnt = this.plNotGlobEnt;
    final int? plScore = this.plScore;

    if (plCapital != null &&
        plWorkers != null &&
        plRnD != null &&
        plRegistered != null &&
        plNotGlobEnt != null &&
        plScore != null) {
      return CompanyScoreData(
          plCapital: plCapital.toDouble(),
          plWorkers: plWorkers != 0,
          plRnD: plRnD != 0,
          plRegistered: plRegistered != 0,
          plNotGlobEnt: plNotGlobEnt != 0,
          plScore: plScore);
    }
  }
}

class _ScoreSection extends StatelessWidget {
  final Company company;

  const _ScoreSection({super.key, required this.company});

  @override
  Widget build(BuildContext context) {
    final scoreData = company.scoreData();

     if (scoreData != null) {
      if (scoreData.plScore == 0) {
      }
      return CompanyScoreWidget(data: scoreData);
    } else {
      return Container();
    }
  }
}
