import 'package:flutter/material.dart';
import 'package:pola_flutter/models/search_result.dart';

class ResultListItem extends StatelessWidget {
  ResultListItem(this.searchResult);

  final SearchResult searchResult;

  @override
  Widget build(BuildContext context) {
    final textStyle = TextStyle(fontWeight: FontWeight.normal, fontSize: 16.0);
    return _ListItem(
      child: Column(
      children: [
        Expanded(
          child: Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: EdgeInsets.all(4.0),
              child: Text(searchResult.name!, style: textStyle,)
            )
          )
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: ClipRRect(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(5),
              bottomRight: Radius.circular(5)
            ),
            child: LinearProgressIndicator(
              value:(searchResult.companies?.first.plScore ?? 0) / 100.toDouble(),
              backgroundColor: Colors.white,
              semanticsLabel: 'Linear progress indicator',
            ),
          ),
        )],
      )
    );
  }
}

class LoadingListItem extends StatelessWidget {
  LoadingListItem();

  @override
  Widget build(BuildContext context) {
    final textStyle = TextStyle(fontWeight: FontWeight.normal, fontSize: 16.0);
    return _ListItem(
      child: Expanded(
        child: Align(
          alignment: Alignment.centerLeft,
          child: Padding(
            padding: EdgeInsets.all(4.0),
            child: Row(
              children: [
              CircularProgressIndicator(),
              Padding(
                  padding: EdgeInsets.only(left: 8.0),
                  child: Text("Ładowanie...",style: textStyle,)
              )]
            )
          ),
        ),
      ) 
    );
  }
}

class _ListItem extends StatelessWidget {
  final Widget child;

  const _ListItem({required this.child});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 4.0, left: 8.0, right: 8.0, bottom: 4.0),
      child: Container(
        height: 50,
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(5),
                topRight: Radius.circular(5),
                bottomRight: Radius.circular(5),
                bottomLeft: Radius.circular(5)),
          ),
          child: child,
        ),
      ),
    );
  }
}
