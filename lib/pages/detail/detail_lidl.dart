import 'package:flutter/material.dart';
import 'package:pola_flutter/models/search_result.dart';
import 'package:pola_flutter/ui/progress_indicator_text.dart';

class LidlDetailPage extends StatelessWidget {
  const LidlDetailPage({super.key, required this.searchResult});

  final SearchResult searchResult;

  @override
  Widget build(BuildContext context) {
    final companies = searchResult.companies;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(searchResult.name ?? ""),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(12.0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  searchResult.name ?? "",
                  style: TextStyle(fontSize: 18.0),
                ),
              ),
            ),
            LinearProgressIndicatorWithText(progress: 0, text: "?"),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.all(4.0),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(companies![1].name ?? ""),
                    ),
                  ),
                  LinearProgressIndicatorWithText(
                    progress: (companies[1].plScore ?? 0).toDouble(),
                    text: "(${companies[1].plScore ?? 0})",
                  ),
                  Padding(
                    padding: EdgeInsets.all(4.0),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(companies[0].name ?? ""),
                    ),
                  ),
                  LinearProgressIndicatorWithText(
                    progress: (companies[0].plScore ?? 0).toDouble(),
                    text: "(${companies[0].plScore ?? 0})",
                  ),
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(companies[0].description ?? ""),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
