import 'package:flutter/material.dart';
import 'package:pola_flutter/analytics/pola_analytics.dart';
import 'package:pola_flutter/pages/scan/remote_button.dart';
import 'package:pola_flutter/pages/scan/scan_state.dart';
import 'package:pola_flutter/ui/list_item.dart';

class CompaniesList extends StatelessWidget {
  CompaniesList(this.state, this.listScrollController);

  final ScanState state;
  final ScrollController listScrollController;
  final PolaAnalytics _analytics = PolaAnalytics.instance();

  @override
  Widget build(BuildContext context) {
    final int listSize = state.list.length;

    _scrollToTop();

    double maxHeight;
    if (listSize == 1) {
      maxHeight = 47.5;
    } else if (listSize == 2) {
      maxHeight = 95.0;
    } else if (listSize == 3) {
      maxHeight = 142.5;
    } else {
      maxHeight = 190.0;
    }

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        _ListHeader(listSize: listSize),
        Container(
          constraints: BoxConstraints(
            maxHeight: maxHeight,
          ),
          child: Align(
            alignment: Alignment.bottomCenter,
            child: ListView.builder(
              controller: listScrollController,
              reverse: true,
              itemCount: listSize + (state.isLoading ? 1 : 0),
              itemBuilder: (BuildContext context, int index) {
                if (index == listSize) {
                  return LoadingListItem();
                }
                return GestureDetector(
                  child: ResultListItem(state.list[index]),
                  onTap: () {
                    final result = state.list[index];
                    _analytics.opensCard(result);
                    Navigator.pushNamed(context, '/detail', arguments: result);
                  },
                );
              },
            ),
          ),
        ),
        RemoteButton(RemoteButtonState(
          state.list.firstOrNull?.donate,
          state.list.firstOrNull?.code,
        )),
      ],
    );
  }

  void _scrollToTop() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (listScrollController.hasClients) {
        final position = listScrollController.position.maxScrollExtent;
        listScrollController.jumpTo(position);
      }
    });
  }
}

class _ListHeader extends StatelessWidget {
  final int listSize;

  const _ListHeader({required this.listSize});

  @override
  Widget build(BuildContext context) {
    if (listSize > 0) {
      return Padding(
        padding: const EdgeInsets.only(left: 16.0),
        child: Align(
          alignment: Alignment.centerLeft,
          child: Text(
            'Ostatnie skany:',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
      );
    } else {
      return Container();
    }
  }
}
