import 'package:flutter/material.dart';
import 'package:pola_flutter/models/search_result.dart';
import 'package:pola_flutter/pages/detail/detail_app_bar.dart';
import 'package:pola_flutter/pages/detail/detail_content.dart';
import 'package:pola_flutter/pages/detail/detail_lidl.dart';

class DetailPage extends StatelessWidget {
  const DetailPage({super.key, required this.searchResult});

  final SearchResult searchResult;

  @override
  Widget build(BuildContext context) {
    if (searchResult.companies != null && searchResult.companies!.length == 2) {
      return LidlDetailPage(searchResult: searchResult);
    }

    return LayoutBuilder(
      builder: (context, constraints) => Scaffold(
        backgroundColor: Colors.white,

        appBar: buildDetailAppBar(
          context,
          title: searchResult.name ?? '',
          availableWidth: constraints.maxWidth,
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [SizedBox(height: 16.0), DetailContent(searchResult)],
            ),
          ),
        ),
      ),
    );
  }
}
