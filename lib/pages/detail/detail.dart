import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pola_flutter/models/company.dart';
import 'package:pola_flutter/analytics/pola_analytics.dart';
import 'package:pola_flutter/models/search_result.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:pola_flutter/i18n/strings.g.dart';

import 'detail_lidl.dart';
import 'polish_capital_graph.dart';

class DetailPage extends StatelessWidget {
  DetailPage({Key? key, required this.searchResult}) : super(key: key);

  final SearchResult searchResult;

  @override
  Widget build(BuildContext context) {
    if (searchResult.companies != null && searchResult.companies!.length == 2) {
      return LidlDetailPage(searchResult: searchResult);
    }

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(searchResult.name ?? ""),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 16.0),

              _DetailContent(searchResult),
            ],
          ),
        ),
      ),
    );
  }
}

 class _DetailContent extends StatelessWidget {
  _DetailContent(this.searchResult);

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
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 17.0),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Row(
                children: [
                  SvgPicture.asset(
                    'assets/info.svg',
                    height: 24.0,
                    width: 24.0,
                  ),
                  SizedBox(width: 8.0),
                  
                  Text(
                      t.companyScreen.ourRating,
                    style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.w600,
                      fontFamily: 'Lato',
                    ),
                  ),
                  SizedBox(width: 8.0),
                  Text(
                     t.companyScreen. points(score: score),
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.w700,
                      fontFamily: 'Lato',
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 17.0),
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
            indent: 17.0,
            endIndent: 17.0,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 17.0, top: 22.0),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                  t.companyScreen.gradingCriteria,
                style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.w600,
                  fontFamily: 'Lato',
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
                    _DetailItem(  t.companyScreen.producedInPoland, (company.plWorkers ?? 0) != 0),
                    SizedBox(height: 14.0),
                    _DetailItem(  t.companyScreen.researchInPoland, (company.plRnD ?? 0) != 0),
                    SizedBox(height: 14.0),
                    _DetailItem(  t.companyScreen.registeredInPoland, (company.plRegistered ?? 0) != 0),
                    SizedBox(height: 14.0),
                    _DetailItem(  t.companyScreen.notConcernPart, (company.plNotGlobEnt ?? 0) != 0),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 22.0),
          Divider(
            thickness: 1.0,
            color: Color(0xFFF0F0F0),
            indent: 17.0,
            endIndent: 17.0,
          ),
          if (hasDescription) ...[
            Padding(
              padding: EdgeInsets.symmetric(vertical: 22.0, horizontal: 17.0),
              child: ExpandableText(company.description ?? ""),
            ),
            if (hasLogo) Divider(
              thickness: 1.0,
              color: Color(0xFFF0F0F0),
              indent: 17.0,
              endIndent: 17.0,
            ),
          ],
          if (hasLogo) _Logotypes(logotypes: searchResult.logotypes(), searchResult: searchResult),
          SizedBox(height: 26.0),
          if (hasLogo) Divider(
            thickness: 1.0,
            color: Color(0xFFF0F0F0),
            indent: 17.0,
            endIndent: 17.0,
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
            ),
            softWrap: true,
            overflow: TextOverflow.visible,
          ),
        ),
      ],
    );
  }
}

class Logotype {
  final String imageUrl;
  final String? websiteUrl;

  Logotype(this.imageUrl, this.websiteUrl);
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

class _Logotypes extends StatelessWidget {
  final List<Logotype> logotypes;
  final SearchResult searchResult;
  final PolaAnalytics analytics = PolaAnalytics.instance();

  _Logotypes({required this.logotypes, required this.searchResult});

  @override
  Widget build(BuildContext context) {
    if (logotypes.isEmpty) {
      return Container();
    }
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: logotypes.map((logotype) {
          return GestureDetector(
            onTap: () {
              final url = logotype.websiteUrl;
              if (url == null) return;
              final Uri? uri = Uri.tryParse(url);
              if (uri == null) return;

              analytics.readMore(searchResult, url);
              launchUrl(
                uri,
                mode: LaunchMode.externalApplication,
              );
            },
            child: Padding(
              padding: EdgeInsets.all(8.0),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  color: Color(0xFFF8F8F8),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.3),
                      spreadRadius: 1,
                      blurRadius: 5,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: _LogoView(logotype.imageUrl),
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}

class _LogoView extends StatelessWidget {
  _LogoView(this.url);

  final String url;

  @override
  Widget build(BuildContext context) {
    return Image.network(url, height: 60.0, fit: BoxFit.contain);
  }
}

class ExpandableText extends StatefulWidget {
  final String text;
  ExpandableText(this.text);

  @override
  _ExpandableTextState createState() => _ExpandableTextState();
}

class _ExpandableTextState extends State<ExpandableText> {
  bool isExpanded = false;

   @override
  Widget build(BuildContext context) {
    final link = TextSpan(
      style: TextStyle(
        color: Color(0xFF898989),
        fontSize: 11.0,
        fontWeight: FontWeight.w700,
        fontFamily: 'Lato',
      ),
      text: isExpanded ?  t.companyScreen.seeLess :  t.companyScreen.seeMore,
      recognizer: TapGestureRecognizer()
        ..onTap = () {
          setState(() {
            isExpanded = !isExpanded;
          });
        },
    );

    return LayoutBuilder(
      builder: (context, constraints) {
        final textSpan = TextSpan(
          text: widget.text,
          style: TextStyle(
            color: Colors.black,
            fontSize: 11.0,
            fontWeight: FontWeight.w400,
            fontFamily: 'Lato',
          ),
        );

        final textPainter = TextPainter(
          text: textSpan,
          maxLines: isExpanded ? null : 3,
          ellipsis: '...',
          textDirection: TextDirection.ltr,
        );

        textPainter.layout(
          minWidth: constraints.minWidth,
          maxWidth: constraints.maxWidth,
        );

        final linkTextPainter = TextPainter(
          text: link,
          textDirection: TextDirection.ltr,
        );

        linkTextPainter.layout(
          minWidth: constraints.minWidth,
          maxWidth: constraints.maxWidth,
        );

        if (!isExpanded && textPainter.didExceedMaxLines) {
          final pos = textPainter.getPositionForOffset(Offset(
            textPainter.width - linkTextPainter.width,
            textPainter.height,
          ));
          final end = textPainter.getOffsetBefore(pos.offset);
          final text = TextSpan(
            text: widget.text.substring(0, end),
            style: TextStyle(color: Colors.black),
            children: [link],
          );

          return RichText(
            text: text,
          );
        } else {
          return RichText(
            text: TextSpan(
              text: widget.text,
              style: TextStyle(color: Colors.black),
              children: [if (isExpanded) link],
            ),
          );
        }
      },
    );
  }
}
