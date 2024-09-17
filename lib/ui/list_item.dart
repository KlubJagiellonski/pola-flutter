import 'package:flutter/material.dart';
import 'package:pola_flutter/models/search_result.dart';
import 'package:pola_flutter/theme/assets.gen.dart';
import 'package:pola_flutter/theme/colors.dart';
import 'package:pola_flutter/theme/fonts.gen.dart';
import 'package:pola_flutter/theme/text_size.dart';

class ResultListItem extends StatelessWidget {
  ResultListItem(this.searchResult);

  final SearchResult searchResult;

  @override
  Widget build(BuildContext context) {
    final pointsStyle = TextStyle(
      fontWeight: FontWeight.w700,
      fontFamily: FontFamily.roboto,
      fontSize: TextSize.mediumTitle,
      color: Colors.white,
    );

    final pktStyle = TextStyle(
      fontWeight: FontWeight.w700,
      fontFamily: FontFamily.roboto,
      fontSize: 9,
      color: Colors.white,
    );

    return _ListItem(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: AppColors.defaultRed,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                bottomLeft: Radius.circular(20),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black,
                  offset: Offset(2, 2),
                  blurRadius: 4,
                ),
              ],
            ),
            alignment: Alignment.center,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  '${searchResult.companies?.first.plScore ?? 0}',
                  style: pointsStyle,
                  textAlign: TextAlign.center,
                ),
                Text(
                  'pkt',
                  style: pktStyle,
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
          SizedBox(width: 8.0),
          Expanded(
            child: Container(
              padding: EdgeInsets.only(top: 10.0),
              alignment: Alignment.centerLeft,
              child: Text(
                searchResult.name!,
                style: TextStyle(
                  fontWeight: FontWeight.normal,
                  fontSize: TextSize.mediumTitle,
                ),
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class LoadingListItem extends StatelessWidget {
  LoadingListItem();

  @override
  Widget build(BuildContext context) {
    final textStyle = TextStyle(
      fontWeight: FontWeight.normal,
      fontSize: TextSize.mediumTitle,
    );
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
                  "Proszę czekać, trwa Ładowanie...",
                  style: textStyle,
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
      padding: EdgeInsets.only(top: 4.0, left: 16.0, right: 68.0, bottom: 4.0),
      child: Container(
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
            children: [
              Expanded(child: child),
              Padding(
                padding: EdgeInsets.only(right: 8.0),
                child: Assets.menuPage.showmore.svg(
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
