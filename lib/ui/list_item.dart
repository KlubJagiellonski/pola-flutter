import 'package:flutter/material.dart';
import 'package:pola_flutter/i18n/strings.g.dart';
import 'package:pola_flutter/models/search_result.dart';
import 'package:pola_flutter/theme/assets.gen.dart';
import 'package:pola_flutter/theme/colors.dart';
import 'package:pola_flutter/theme/fonts.gen.dart';
import 'package:pola_flutter/theme/text_size.dart';

class ResultListItem extends StatelessWidget {
  ResultListItem(this.searchResult);

  final SearchResult searchResult;
  static const double leftBoxSize = 40.0;

  @override
  Widget build(BuildContext context) {
    final pointValueStyle = TextStyle(
      fontWeight: FontWeight.w700,
      fontFamily: FontFamily.roboto,
      fontSize: TextSize.mediumTitle,
      color: Colors.white,
    );

    final pointDescriptionStyle = TextStyle(
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
            width: leftBoxSize,
            height: leftBoxSize,
            decoration: BoxDecoration(
              color: AppColors.defaultRed,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(leftBoxSize / 2),
                bottomLeft: Radius.circular(leftBoxSize / 2),
              ),
            ),
            alignment: Alignment.center,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  '${searchResult.companies?.first.plScore ?? 0}',
                  style: pointValueStyle,
                  textAlign: TextAlign.center,
                ),
                Text(
                  t.scan.pkt,
                  style: pointDescriptionStyle,
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
          SizedBox(width: 8.0),
          Expanded(
            child: Container(
              alignment: Alignment.centerLeft,
              child: Text(
                searchResult.name!,
                style: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: TextSize.smallTitle,
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
                    fontWeight:
                        FontWeight.w400,
                    fontSize:
                        TextSize.smallTitle,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      showMore: false,
    );
  }
}

class _ListItem extends StatelessWidget {
  final Widget child;
  final bool showMore;

  const _ListItem({
    required this.child,
    this.showMore = true,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 4.0, left: 16.0, right: 8.0, bottom: 4.0),
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
              if (showMore)
                Padding(
                  padding: EdgeInsets.only(right: 8.0),
                  child: Assets.scan.showMore.svg(),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
