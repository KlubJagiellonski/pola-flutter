import 'package:flutter/material.dart';
import 'package:pola_flutter/models/search_result.dart';
import 'detail_lidl.dart';
import 'detail_content.dart';

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
              DetailContent(searchResult),
            ],
          ),
        ),
      ),
    );
  }
}
