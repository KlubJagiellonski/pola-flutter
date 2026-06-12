import 'package:flutter/material.dart';
import 'package:pola_flutter/i18n/strings.g.dart';
import 'package:pola_flutter/models/search_result.dart';
import 'package:pola_flutter/ui/product_list_item.dart';
import 'package:pola_flutter/theme/text_size.dart';

class ResultListItem extends StatelessWidget {
  const ResultListItem({super.key, required this.searchResult});

  final SearchResult searchResult;
  static const double leftBoxSize = 40.0;

  @override
  Widget build(BuildContext context) {
    return ProductListItem(
      score: searchResult.companies?.first.plScore ?? 0,
      title: searchResult.name ?? '',
      height: leftBoxSize,
      scoreWidth: leftBoxSize,
    );
  }
}

class LoadingListItem extends StatelessWidget {
  const LoadingListItem({super.key});

  @override
  Widget build(BuildContext context) {
    return _ListItem(
      child: Align(
        alignment: Alignment.centerLeft,
        child: Padding(
          padding: EdgeInsets.all(4.0),
          child: Row(
            children: [
              CircularProgressIndicator(),
              Padding(
                padding: EdgeInsets.only(left: 8.0),
                child: Text(
                  t.scan.wait,
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: TextSize.smallTitle,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ListItem extends StatelessWidget {
  final Widget child;

  const _ListItem({required this.child});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 4.0, left: 16.0, right: 8.0, bottom: 4.0),
      child: SizedBox(
        height: 40,
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30),
              topRight: Radius.circular(30),
              bottomRight: Radius.circular(30),
              bottomLeft: Radius.circular(30),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [Expanded(child: child)],
          ),
        ),
      ),
    );
  }
}
