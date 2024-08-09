import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pola_flutter/models/company.dart';
import 'package:pola_flutter/models/search_result.dart';
import 'package:pola_flutter/i18n/strings.g.dart';
import 'package:pola_flutter/ui/web_view_dialog.dart';
import 'logotypes.dart';
import 'expandandable_text.dart';
import 'polish_capital_graph.dart';

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
    final score = company.plScore ?? 0;
    final double plCapital = (company.plCapital ?? 0).toDouble();
    final Translations t = Translations.of(context);

    final hasLogo = company.logotypeUrl != null;
    final hasDescription = company.description?.isNotEmpty ?? false;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if ((company.isFriend ?? false))
          GestureDetector(
            onTap: () {
              final url = 'https://www.pola-app.pl/m/friends';
              showDialog(
                context: context,
                builder: (context) {
                  return WebViewDialog(url: url, title: " Przyjaciele Poli");
                },
              );
            },
            child: Container(
              height: 40.0,
              color: const Color(0xFFF5DEDD),
              alignment: Alignment.center,
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 9.0),
                    child: SvgPicture.asset(
                      'assets/favorite.svg',
                      height: 13.0,
                      width: 15.0,
                    ),
                  ),
                  Expanded(
                    child: Center(
                      child: Text(
                        "Ta firma jest przyjacielem Poli",
                        style: TextStyle(
                          fontSize: 12.0,
                          fontWeight: FontWeight.bold,
                          color: const Color(0xFFE1203E),
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 9.0),
                    child: SvgPicture.asset(
                      'assets/favorite.svg',
                      height: 13.0,
                      width: 15.0,
                    ),
                  ),
                ],
              ),
            ),
          ),
        const SizedBox(height: 20.0),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 17.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: Row(
                  children: [
                    SvgPicture.asset(
                      'assets/info.svg',
                      height: 24.0,
                      width: 24.0,
                    ),
                    const SizedBox(width: 8.0),
                    Text(
                      t.companyScreen.ourRating,
                      style: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.w600,
                        fontFamily: 'Lato',
                        color: const Color(0xFF1C1B1F),
                      ),
                    ),
                    const SizedBox(width: 8.0),
                    Text(
                      t.companyScreen.points(score: score),
                      style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.w700,
                        fontFamily: 'Lato',
                        color: const Color(0xFF1C1B1F),
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
                    backgroundColor: const Color(0xFFF5DEDD),
                    valueColor:
                        const AlwaysStoppedAnimation<Color>(Color(0xFFE1203E)),
                    minHeight: 12.0,
                  ),
                ),
              ),
              const SizedBox(height: 17.0),
              Divider(
                thickness: 1.0,
                color: const Color(0xFFF0F0F0),
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
                      fontSize: 16.0,
                      fontWeight: FontWeight.w600,
                      fontFamily: 'Lato',
                      color: const Color(0xFF1C1B1F),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 22.0),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  PolishCapitalGraph(percentage: plCapital),
                  const SizedBox(width: 35.0),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _DetailItem(t.companyScreen.producedInPoland,
                            (company.plWorkers ?? 0) != 0),
                        const SizedBox(height: 14.0),
                        _DetailItem(t.companyScreen.researchInPoland,
                            (company.plRnD ?? 0) != 0),
                        const SizedBox(height: 14.0),
                        _DetailItem(t.companyScreen.registeredInPoland,
                            (company.plRegistered ?? 0) != 0),
                        const SizedBox(height: 14.0),
                        _DetailItem(t.companyScreen.notConcernPart,
                            (company.plNotGlobEnt ?? 0) != 0),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 22.0),
              Divider(
                thickness: 1.0,
                color: const Color(0xFFF0F0F0),
                indent: 0,
                endIndent: 0,
              ),
              if (hasDescription) ...[
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 22.0),
                  child: ExpandableText(company.description ?? ""),
                ),
                if (hasLogo)
                  Divider(
                    thickness: 1.0,
                    color: const Color(0xFFF0F0F0),
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
                  color: const Color(0xFFF0F0F0),
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
          child: SvgPicture.asset(
            state ? 'assets/task_alt.svg' : 'assets/radio_button_unchecked.svg',
          ),
        ),
        Expanded(
          child: Text(
            text,
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w400,
              fontFamily: 'Lato',
              color: const Color(0xFF1C1B1F),
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
