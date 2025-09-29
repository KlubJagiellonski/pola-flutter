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
            _ReplacementsText(searchResult),
          ],
        ),
      ),
    );
  }
}

class _ReplacementsText extends StatelessWidget {
  final SearchResult searchResult;
  const _ReplacementsText(this.searchResult, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final replacements = searchResult.replacements;
    if (replacements == null || replacements.isEmpty) {
      return SizedBox.shrink();
    }

    final text = replacements
        .map((r) {
          final name = r.name ?? '';
          final companyDisplay = r.displayName ?? r.company ?? '';
          if (name.isEmpty && companyDisplay.isEmpty) return null;
          return "$name ($companyDisplay)".trim();
        })
        .whereType<String>()
        .where((s) => s.isNotEmpty)
        .join(", ");

    if (text.isEmpty) {
      return SizedBox.shrink();
    }

    return Padding(
      padding: EdgeInsets.all(8.0),
      child: RichText(
        text: TextSpan(
          style: DefaultTextStyle.of(context).style,
          children: [
            TextSpan(
                text: 'Polskie zamienniki: ',
                style: TextStyle(fontWeight: FontWeight.bold)),
            TextSpan(text: text),
          ],
        ),
      ),
    );
  }
}
