import 'package:flutter/material.dart';
import 'package:pola_flutter/analytics/pola_analytics.dart';
import 'package:pola_flutter/pages/scan/remote_button.dart';
import 'package:pola_flutter/ui/list_item.dart';
import 'scan_bloc.dart';

class CompaniesList extends StatelessWidget {
  CompaniesList(this.state, this.listScrollController);

  final ScanLoaded state;
  final ScrollController listScrollController;
  final PolaAnalytics _analytics = PolaAnalytics.instance();

  @override
  Widget build(BuildContext context) {
    _scrollToTop();
    return Column(mainAxisAlignment: MainAxisAlignment.end, children: <Widget>[
      Container(
        height: 200,
        child: Align(
          alignment: Alignment.bottomCenter,
          child: ListView.builder(
            controller: listScrollController,
            reverse: true,
            itemCount: state.list.length,
            itemBuilder: (BuildContext context, int index) {
              return GestureDetector(
                child: ListItem(state.list[index]),
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
