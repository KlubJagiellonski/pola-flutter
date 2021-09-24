import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:pola_flutter/models/search_result.dart';

class ListItem extends StatelessWidget {
  ListItem(this.searchResult);

  final SearchResult searchResult;

  @override
  Widget build(BuildContext context) {
    final textStyle = TextStyle(fontWeight: FontWeight.normal, fontSize: 16.0);
    return Padding(
      padding: EdgeInsets.only(top: 6.0, left: 8.0, right: 8.0, bottom: 2.0),
      child: Container(
        height: 40,
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10),
                topRight: Radius.circular(10),
                bottomRight: Radius.circular(5),
                bottomLeft: Radius.circular(5)),
          ),
          child: Column(
            children: [
              Expanded(
                  child: Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                          padding: EdgeInsets.all(4.0),
                          child: Text(
                            searchResult.name!,
                            style: textStyle,
                          )))),
              Align(
                alignment: Alignment.bottomCenter,
                child: ClipRRect(
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(10),
                      bottomRight: Radius.circular(10)),
                  child: LinearProgressIndicator(
                    value: (searchResult.companies?.first.plScore ?? 0) /
                        100.toDouble(),
                    backgroundColor: Colors.white,
                    semanticsLabel: 'Linear progress indicator',
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
