import 'package:flutter/material.dart';
import 'package:pola_flutter/models/company.dart';
import 'package:pola_flutter/models/search_result.dart';
import 'package:pola_flutter/i18n/strings.g.dart';
import 'package:pola_flutter/theme/fonts.gen.dart';
import 'package:pola_flutter/theme/text_size.dart';
import 'logotypes.dart';
import 'expandandable_text.dart';
import 'polish_capital_graph.dart';
import 'package:pola_flutter/theme/assets.gen.dart';

class DetailContent extends StatelessWidget {
  DetailContent(this.searchResult);

  final SearchResult searchResult;

  @override
  Widget build(BuildContext context) {
    if (searchResult.companies == null) {
      return Padding(
        padding: EdgeInsets.all(8.0),
        child: Text(searchResult.altText ?? ""),
      );
    }

    final company = searchResult.companies!.first;
    final score = company.plScore ?? 0;
    final double plCapital = (company.plCapital ?? 0).toDouble();
    final Translations t = Translations.of(context);

    final hasLogo = company.logotypeUrl != null;
    final hasDescription = company.description?.isNotEmpty ?? false;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 17.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Row(
              children: [
                Assets.info.svg(height: 24.0,width: 24.0),
                // SvgPicture.asset(
                //   'assets/info.svg',
                //   height: 24.0,
                //   width: 24.0,
                // ),

                SizedBox(width: 8.0),
                Text(
                  t.companyScreen.ourRating,
                  style: TextStyle(
                    fontSize: TextSize.mediumTitle,
                    fontWeight: FontWeight.w600,
                    fontFamily: FontFamily.lato,
                     color: Color(0xFF1C1B1F),
                  ),
                ),
                SizedBox(width: 8.0),
                Text(
                  t.companyScreen.points(score: score),
                  style: TextStyle(
                    fontSize: TextSize.newsTitle,
                    fontWeight: FontWeight.w700,
                    fontFamily: FontFamily.lato,
                     color: Color(0xFF1C1B1F),
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
                backgroundColor: Color(0xFFF5DEDD),
                valueColor: AlwaysStoppedAnimation<Color>(Color(0xFFE1203E)),
                minHeight: 12.0,
              ),
            ),
          ),
          SizedBox(height: 17.0),
          Divider(
            thickness: 1.0,
            color: Color(0xFFF0F0F0),
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
                   color: Color(0xFF1C1B1F),
                ),
              ),
            ),
          ),
          SizedBox(height: 22.0),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              PolishCapitalGraph(percentage: plCapital),
              SizedBox(width: 35.0),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _DetailItem(t.companyScreen.producedInPoland,
                        (company.plWorkers ?? 0) != 0),
                    SizedBox(height: 14.0),
                    _DetailItem(t.companyScreen.researchInPoland,
                        (company.plRnD ?? 0) != 0),
                    SizedBox(height: 14.0),
                    _DetailItem(t.companyScreen.registeredInPoland,
                        (company.plRegistered ?? 0) != 0),
                    SizedBox(height: 14.0),
                    _DetailItem(t.companyScreen.notConcernPart,
                        (company.plNotGlobEnt ?? 0) != 0),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 22.0),
          Divider(
            thickness: 1.0,
            color: Color(0xFFF0F0F0),
            indent: 0,
            endIndent: 0,
          ),
          if (hasDescription) ...[
            Padding(
              padding: EdgeInsets.symmetric(vertical: 22.0),
              child: ExpandableText(company.description ?? ""),
            ),
            if (hasLogo)
              Divider(
                thickness: 1.0,
                color: Color(0xFFF0F0F0),
                indent: 0,
                endIndent: 0,
              ),
          ],
          if (hasLogo)
            Logotypes(
                logotypes: searchResult.logotypes(),
                searchResult: searchResult),
          SizedBox(height: 26.0),
          if (hasLogo)
            Divider(
              thickness: 1.0,
              color: Color(0xFFF0F0F0),
              indent: 0,
              endIndent: 0,
            ),
        ],
      ),
    );
  }
}

class _DetailItem extends StatelessWidget {
  _DetailItem(this.text, this.state);

  final String text;
  final bool state;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Padding(
          padding: EdgeInsets.only(right: 3.0),
          child: state ? Assets.taskAlt.svg() : Assets.radioButtonUnchecked.svg()
        ),
        Expanded(
          child: Text(
            text,
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w400,
              fontFamily: FontFamily.lato,
               color: Color(0xFF1C1B1F),
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
