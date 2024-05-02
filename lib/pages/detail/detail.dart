import 'package:flutter/material.dart';
import 'package:pola_flutter/analytics/pola_analytics.dart';
import 'package:pola_flutter/models/brand.dart';
import 'package:pola_flutter/models/search_result.dart';
import 'package:pola_flutter/ui/progress_indicator_text.dart';
import 'package:url_launcher/url_launcher.dart';

import 'detail_lidl.dart';

class DetailPage extends StatelessWidget {
  DetailPage({Key? key, required this.searchResult}) : super(key: key);

  final SearchResult searchResult;

  @override
  Widget build(BuildContext context) {
    if (searchResult.companies != null && searchResult.companies!.length == 2) {
      return LidlDetailPage(searchResult: searchResult);
    }

    final company = searchResult.companies?.first;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(searchResult.name ?? ""),
        leading: new IconButton(
          icon: new Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: SafeArea(
        child:  SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                  padding: EdgeInsets.all(12.0),
                  child: Align(
                    child: Text(searchResult.name ?? "",
                        style: TextStyle(
                          fontSize: 18.0,
                        )),
                    alignment: Alignment.centerLeft,
                  )),
              LinearProgressIndicatorWithText((company?.plScore ?? 0).toDouble(),
                  (((company?.plScore ?? "0").toString()) + " pkt")),
              _DetailContent(searchResult)
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
          child: Text(searchResult.altText ?? ""));
    }
    final company = searchResult.companies!.first;
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.all(8.0),
          child: Column(
            children: [
              Padding(
                  padding: EdgeInsets.all(4.0),
                  child: Align(
                    child: Text("udział polskiego kapitału"),
                    alignment: Alignment.centerLeft,
                  )),
              LinearProgressIndicatorWithText(
                  (company.plCapital ?? 0).toDouble(),
                  (company.plCapital ?? 0).toString() + "%"),
            ],
          ),
        ),
        _DetailItem("produkuje w Polsce", (company.plWorkers ?? 0) != 0),
        _DetailItem("prowadzi badania w Polsce", (company.plRnD ?? 0) != 0),
        _DetailItem("zarejestrowana w Polsce", (company.plRegistered ?? 0) != 0),
        _DetailItem("nie jest częścią zagranicznego koncernu",
            (company.plNotGlobEnt ?? 0) != 0),
        Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(company.description ?? "")),
        _DetailCompanyLogotype(company.logotypeUrl),
        _BrandLogotypes(searchResult.allCompanyBrands),
        _ReadMoreButton(searchResult)
      ],
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
            child: Container(
              child: Checkbox(
                checkColor: Colors.white,
                value: state,
                onChanged: (bool? value) {},
              ),
            ),
          ),
        ),
        Text(text)
      ],
    );
  }
}

class _ReadMoreButton extends StatelessWidget {
  _ReadMoreButton(this.searchResult);

  final SearchResult searchResult;
  final PolaAnalytics _analytics = PolaAnalytics.instance();

  @override
  Widget build(BuildContext context) {
    final stringUrl = searchResult.companies?.first.officialUrl;
    if (stringUrl == null) {
      return Container();
    }
    Uri? url = Uri.tryParse(stringUrl);
    if (url == null) {
      return Container();
    }

    return ElevatedButton(
      onPressed: () {
        _analytics.readMore(searchResult, stringUrl);
        launchUrl(
          url,
          mode: LaunchMode.externalApplication,
        );
      },
      child: Text("Czytaj więcej!"),
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

class _BrandLogotypes extends StatelessWidget {
  _BrandLogotypes(this.brands);

  final List<Brand>? brands;

  @override
  Widget build(BuildContext context) {
    final logotypes = brands?.map((brand) => brand.logotypeUrl).where((url) => url != null).toList().cast<String>();
    if (logotypes == null) {
      return Container();
    }

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: logotypes
            .map((logotypeUrl) => Padding(
                padding: EdgeInsets.all(8.0),
                child: _LogoView(logotypeUrl)))
            .toList(),
      ),
    );
  }
}

class _LogoView extends StatelessWidget {
  _LogoView(this.url);

  final String url;

  @override
  Widget build(BuildContext context) {
    return Image.network(url, height: 100.0, fit: BoxFit.contain);
  }
}
