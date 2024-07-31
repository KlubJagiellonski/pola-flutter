import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pola_flutter/models/company.dart';
import 'package:pola_flutter/analytics/pola_analytics.dart';
import 'package:pola_flutter/models/search_result.dart';
import 'package:url_launcher/url_launcher.dart';

import 'detail_lidl.dart';
import 'polish_capital_grapho.dart';

class DetailPage extends StatelessWidget {
  DetailPage({Key? key, required this.searchResult}) : super(key: key);

  final SearchResult searchResult;
  final PolaAnalytics _analytics = PolaAnalytics.instance();

  void _handleReadMoreClick(BuildContext context, String? url) {
    if (url == null) return;
    final Uri? uri = Uri.tryParse(url);
    if (uri == null) return;

    _analytics.readMore(searchResult, url);
    launchUrl(
      uri,
      mode: LaunchMode.externalApplication,
    );
  }

  @override
  Widget build(BuildContext context) {
    if (searchResult.companies != null && searchResult.companies!.length == 2) {
      return LidlDetailPage(searchResult: searchResult);
    }

    final company = searchResult.companies?.first;
    final score = company?.plScore ?? 0;

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
                        "Nasza ocena:",
                        style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(width: 8.0),
                      Text(
                        "$score pkt",
                        style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
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
                    minHeight: 12.0, // Set the thickness to 12 px
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 17.0, top: 8.0),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Kryteria oceniania",
                    style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
              _DetailContent(searchResult, _handleReadMoreClick),
            ],
          ),
        ),
      ),
    );
  }
}

class _DetailContent extends StatelessWidget {
  _DetailContent(this.searchResult, this.onReadMoreClick);

  final SearchResult searchResult;
  final void Function(BuildContext, String?) onReadMoreClick;

  @override
  Widget build(BuildContext context) {
    if (searchResult.companies == null) {
      return Padding(
        padding: EdgeInsets.all(8.0),
        child: Text(searchResult.altText ?? ""),
      );
    }

    final company = searchResult.companies!.first;
    final double plCapital = (company.plCapital ?? 0).toDouble();

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 17.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomRadialGauge(percentage: plCapital),
              SizedBox(width: 16.0),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _DetailItem("produkuje w Polsce", (company.plWorkers ?? 0) != 0),
                    _DetailItem("prowadzi badania w Polsce", (company.plRnD ?? 0) != 0),
                    _DetailItem("zarejestrowana w Polsce", (company.plRegistered ?? 0) != 0),
                    _DetailItem("nie jest częścią zagranicznego koncernu",
                      (company.plNotGlobEnt ?? 0) != 0),
                  ],
                ),
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: ExpandableText(company.description ?? ""),
          ),
          _Logotypes(logotypes: searchResult.logotypes(), searchResult: searchResult)
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
          padding: EdgeInsets.all(4.0),
          child: SizedBox(
            height: 32.0,
            width: 32.0,
            child: SvgPicture.asset(
              state ? 'assets/task_alt.svg' : 'assets/radio_button_unchecked.svg',
              height: 32.0,
              width: 32.0,
            ),
          ),
        ),
        Expanded(
          child: Text(
            text,
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
    }).toList() ?? [];

    final logotypeCompany = companies?.first.logotype();

    brandLogotypes.insert(0, logotypeCompany);

    return brandLogotypes.where((logotype) => logotype != null).cast<Logotype>().toList();
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
      text: isExpanded ? ' zobacz mniej' : ' zobacz więcej',
      style: TextStyle(color: Color(0xFF898989)), // Change to #898989
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
          style: TextStyle(color: Colors.black),
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