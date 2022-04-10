import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pola_flutter/models/search_result.dart';
import 'package:pola_flutter/ui/progress_indicator_text.dart';

class LidlDetailPage extends StatelessWidget {
  LidlDetailPage({Key? key, required this.searchResult}) : super(key: key);

  final SearchResult searchResult;

  @override
  Widget build(BuildContext context) {
    final companies = searchResult.companies;
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
            LinearProgressIndicatorWithText(0, "?"),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Padding(
                      padding: EdgeInsets.all(4.0),
                      child: Align(
                        child: Text(companies![1].name ?? ""),
                        alignment: Alignment.centerLeft,
                      )),
                  LinearProgressIndicatorWithText(
                      (companies[1].plScore ?? 0).toDouble(),
                      (companies[1].plScore ?? 0).toString() + "%"),
                  Padding(
                      padding: EdgeInsets.all(4.0),
                      child: Align(
                        child: Text(companies[0].name ?? ""),
                        alignment: Alignment.centerLeft,
                      )),
                  LinearProgressIndicatorWithText(
                      (companies[0].plScore ?? 0).toDouble(),
                      (companies[0].plScore ?? 0).toString() + "%"),
                  Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(companies[0].description ?? ""))
                ],
              ),
            ),

          ],
        ),
      ),
    );
  }
}
