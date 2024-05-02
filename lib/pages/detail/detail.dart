import 'package:flutter/material.dart';
import 'package:pola_flutter/models/brand.dart';
import 'package:pola_flutter/models/search_result.dart';
import 'package:pola_flutter/ui/progress_indicator_text.dart';

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
              DetailContent(searchResult)
            ],
          ),
        ),
      ),
    );
  }
}

class DetailContent extends StatelessWidget {
  DetailContent(this.searchResult);

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
        DetailItem("produkuje w Polsce", (company.plWorkers ?? 0) != 0),
        DetailItem("prowadzi badania w Polsce", (company.plRnD ?? 0) != 0),
        DetailItem("zarejestrowana w Polsce", (company.plRegistered ?? 0) != 0),
        DetailItem("nie jest częścią zagranicznego koncernu",
            (company.plNotGlobEnt ?? 0) != 0),
        Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(company.description ?? "")),
        DetailCompanyLogotype(company.logotypeUrl),
        BrandLogotypes(searchResult.allCompanyBrands)
      ],
    );
  }
}

class DetailItem extends StatelessWidget {
  DetailItem(this.text, this.state);

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

class DetailCompanyLogotype extends StatelessWidget {
  DetailCompanyLogotype(this.url);

  final String? url;

  @override
  Widget build(BuildContext context) {
    final url = this.url;
    if (url == null) {
      return Container();
    }

    return Image.network(url, height: 100.0, fit: BoxFit.contain);
  }
}

class BrandLogotypes extends StatelessWidget {
  BrandLogotypes(this.brands);

  final List<Brand>? brands;

  @override
  Widget build(BuildContext context) {
        final brands = this.brands;
    if (brands == null) {
      return Container();
    }

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: brands
            .map((brand) => Padding(
                padding: EdgeInsets.all(8.0),
                child: LogoView(brand.logotypeUrl ?? "")))
            .toList(),
      ),
    );
  }
}

class LogoView extends StatelessWidget {
  LogoView(this.url);

  final String url;

  @override
  Widget build(BuildContext context) {
    return Image.network(url, height: 100.0, fit: BoxFit.contain);
  }
}
