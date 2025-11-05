import 'package:flutter/material.dart';
import 'package:pola_flutter/models/company.dart';
import 'package:pola_flutter/models/replacement.dart';
import 'package:pola_flutter/models/search_result.dart';
import 'package:pola_flutter/theme/assets.gen.dart';
import 'package:pola_flutter/theme/colors.dart';
import 'package:pola_flutter/theme/fonts.gen.dart';
import 'package:pola_flutter/theme/text_size.dart';
import 'company_score_widget.dart';
import 'expandandable_text.dart';
import 'logotypes.dart';
import 'no_score_message.dart';
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

    final hasLogo = company.brands.isNotEmpty;
    final hasDescription = company.description?.isNotEmpty ?? false;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if ((company.isFriend ?? false)) FriendsBar(),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 17.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _ScoreSection(company: company, searchResult: searchResult),
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
                    logotypes: company.logotypes(),
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

class DetailItem extends StatelessWidget {
  const DetailItem(this.text, this.state, {Key? key}) : super(key: key);

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

extension on Company {
    List<Logotype> logotypes() {
    return brands.map((brand) {
          return Logotype(brand.logotypeUrl, brand.websiteUrl);
    }).toList();
  }

  CompanyScoreData? _scoreData(List<Replacement>? replacements, String? productCode) {
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
          plScore: plScore,
          replacements: replacements,
          productCode: productCode ?? '');
    }
    return null;
  }
}

class _ScoreSection extends StatelessWidget {
  final Company company;
  final SearchResult searchResult;

  const _ScoreSection({required this.company, required this.searchResult});

  @override
  Widget build(BuildContext context) {
    final scoreData = company._scoreData(searchResult.replacements, searchResult.code);

    if (scoreData != null) {
      return CompanyScoreWidget(data: scoreData);
    } else {
      return NoScoreMessage();
    }
  }
}
