import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:http/retry.dart';
import 'package:pola_flutter/models/company.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';
import 'package:pola_flutter/analytics/pola_analytics.dart';
import 'package:pola_flutter/models/brand.dart';
import 'package:pola_flutter/models/search_result.dart';
import 'package:url_launcher/url_launcher.dart';

import 'detail_lidl.dart';

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
                padding: const EdgeInsets.only(left: 18.5, right: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
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
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 17.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10.0),
                  child: LinearProgressIndicator(
                    value: score / 100.0,
                    backgroundColor: Color(0xFFF5DEDD),
                    valueColor: AlwaysStoppedAnimation<Color>(Color(0xFFE1203E)),
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
          _DetailCompanyLogotype(company.logotypeUrl),
          _BrandLogotypes(searchResult.allCompanyBrands, onReadMoreClick, searchResult),
          _Logotypes(logotypes: searchResult.logotypes(), searchResult: searchResult,)
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

class _DetailCompanyLogotype extends StatelessWidget {
  _DetailCompanyLogotype(this.url);

  final String? url;

  @override
  Widget build(BuildContext context) {
    final url = this.url;
    if (url == null) {
      return Container();
    }

    return _LogoView(url);
  }
}

class Logotype {
  final String imageUrl;
  final String? websiteUrl;

  Logotype(this.imageUrl, this.websiteUrl);
}

extension on SearchResult {
  List<Logotype> logotypes() {
    var brandLogotypes = allCompanyBrands?.map((brand){
      final brandLogotype = brand.logotypeUrl;
      if (brandLogotype != null){
        return Logotype(brandLogotype, null);
      }else {
        return null;
      }
    })
    .toList() ?? [];

    final logotypeCompany = companies?.first.logotype();

    brandLogotypes.insert(0, logotypeCompany);

    return brandLogotypes.nonNulls.toList();
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

  _Logotypes({super.key, required this.logotypes, required this.searchResult});


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

class _BrandLogotypes extends StatelessWidget {
  _BrandLogotypes(this.brands, this.onReadMoreClick, this.searchResult);

  final List<Brand>? brands;
  final void Function(BuildContext, String?) onReadMoreClick;
  final SearchResult searchResult;

  @override
  Widget build(BuildContext context) {
    final logotypes = brands?.map((brand) => brand.logotypeUrl).where((url) => url != null).toList().cast<String>();
    if (logotypes == null || logotypes.isEmpty) {
      return Container();
    }

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: logotypes.map((logotypeUrl) {
          final bool isJagiellonianClub = logotypeUrl.contains('https://klubjagiellonski.pl');  
          return GestureDetector(
            onTap: () {
              if (isJagiellonianClub) {
                onReadMoreClick(context, searchResult.companies?.first.officialUrl);
              }
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
                  child: _LogoView(logotypeUrl),
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

class CustomRadialGauge extends StatelessWidget {
  final double percentage;

  CustomRadialGauge({required this.percentage});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          height: 150.0,
          width: 150.0,
          child: SfRadialGauge(
            axes: <RadialAxis>[
              RadialAxis(
                minimum: 0,
                maximum: 100,
                showLabels: false,
                showTicks: false,
                axisLineStyle: AxisLineStyle(
                  thickness: 0.2,
                  cornerStyle: CornerStyle.bothCurve,
                  color: Color(0xFFF5DEDD),
                  thicknessUnit: GaugeSizeUnit.factor,
                ),
                pointers: <GaugePointer>[
                  RangePointer(
                    value: percentage,
                    cornerStyle: CornerStyle.bothCurve,
                    width: 0.2,
                    sizeUnit: GaugeSizeUnit.factor,
                    color: Color(0xFFE1203E),
                  ),
                ],
                annotations: <GaugeAnnotation>[
                  GaugeAnnotation(
                    positionFactor: 0.1,
                    angle: 90,
                    widget: Text(
                      '${percentage.toInt()}%',
                      style: TextStyle(
                        fontSize: 24.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: Text(
            'Polski kapitał',
            style: TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
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