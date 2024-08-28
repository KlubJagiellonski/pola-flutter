 import 'package:flutter/material.dart';
import 'package:pola_flutter/models/company.dart';
import 'package:pola_flutter/models/search_result.dart';
import 'package:pola_flutter/i18n/strings.g.dart';
import 'package:pola_flutter/theme/assets.gen.dart';
import 'package:pola_flutter/theme/colors.dart';
import 'package:pola_flutter/theme/fonts.gen.dart';
import 'package:pola_flutter/theme/text_size.dart';
import 'logotypes.dart';
import 'expandandable_text.dart';
import 'polish_capital_graph.dart';
import 'friends_bar.dart';

class DetailContent extends StatelessWidget {
  const DetailContent(this.searchResult, {Key? key}) : super(key: key);

  final SearchResult searchResult;

  @override
  Widget build(BuildContext context) {
    if (searchResult.companies == null) {
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(searchResult.altText ?? ""),
      );
    }

    final company = searchResult.companies!.first;
    final score = company.plScore;
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
              if (score == null) ...[
                _buildNoScoreMessage(t),
              ] else ...[
                _buildScoreSection(t, score),
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
                PolishCapitalGraph(percentage: plCapital),
                const SizedBox(height: 22.0),
                Divider(
                  thickness: 1.0,
                  color: AppColors.divider,
                  indent: 0,
                  endIndent: 0,
                ),
              ],
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

  Widget _buildNoScoreMessage(Translations t) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 22.0),
      child: Column(
        children: [
          Assets.company.unpublished.svg(height: 109.42, width: 109.55),  
          const SizedBox(height: 26.0),
          Padding(
          padding: const EdgeInsets.symmetric(horizontal: 115.0),  
          ),
          Text(
            "Niestety, ta firma nie została jeszcze zweryfikowana, więc nie możemy wyświetlić jej oceny. Stale rozszerzamy naszą bazę, aby uwzględnić więcej firm.\n\nDziękujemy za cierpliwość!",
            style: TextStyle(
              fontSize: TextSize.description,
              fontWeight: FontWeight.w400,
              fontFamily: FontFamily.lato,
              color: AppColors.text,
            ),
            textAlign: TextAlign.left,
          ),
        ],
      ),
    );
  }

  Widget _buildScoreSection(Translations t, int score) {
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
                t.companyScreen.points(score: score),
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
            child: LinearProgressIndicator(
              value: score / 100.0,
              backgroundColor: AppColors.buttonBackground,
              valueColor: const AlwaysStoppedAnimation<Color>(AppColors.defaultRed),
              minHeight: 12.0,
            ),
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
          child: state ? Assets.company.taskAlt.svg() : Assets.company.radioButtonUnchecked.svg(),
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
}
