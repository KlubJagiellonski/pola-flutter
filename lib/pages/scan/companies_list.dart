import 'package:flutter/material.dart';
import 'package:pola_flutter/analytics/pola_analytics.dart';
import 'package:pola_flutter/ui/list_item.dart';
import 'package:url_launcher/url_launcher.dart';
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
      Padding(
          padding:
              EdgeInsets.only(left: 8.0, top: 0.0, right: 8.0, bottom: 0.0),
          child: TextButton(
            style: ButtonStyle(
              minimumSize:
                  MaterialStateProperty.all<Size>(Size(double.infinity, 0)),
              backgroundColor: MaterialStateProperty.all<Color>(Colors.red),
              foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
            ),
            onPressed: () async {
              final result = state.list.isNotEmpty ? state.list.first : null;
              _analytics
                  .donateOpened(result?.code ?? "Nie znaleziono produktu");
              launchUrl(
                Uri.parse(result?.donate?.url ?? "https://www.pola-app.pl"),
                mode: LaunchMode.externalApplication,
              );
            },
            child: Text(state.list.isNotEmpty
                ? state.list.first.donate?.title ?? "Wesprzyj nas!"
                : "Wesprzyj nas!"),
          ))
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
