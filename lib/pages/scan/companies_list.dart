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
    _scrollToTop();
    return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Padding(
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
          ),
          Container(
            height: 190,
            child: Align(
              alignment: Alignment.bottomCenter,
              child: ListView.builder(
                controller: listScrollController,
                reverse: true,
                itemCount: state.list.length + (state.isLoading ? 1 : 0),
                itemBuilder: (BuildContext context, int index) {
                  if (index == state.list.length) {
                    return LoadingListItem();
                  }
                  return GestureDetector(
                    child: ResultListItem(state.list[index]),
                    onTap: () {
                      final result = state.list[index];
                      _analytics.opensCard(result);
                      Navigator.pushNamed(context, '/detail',
                          arguments: result);
                    },
                  );
                },
              ),
            ),
          ),
          RemoteButton(RemoteButtonState(
              state.list.firstOrNull?.donate, state.list.firstOrNull?.code))
        ]);
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
