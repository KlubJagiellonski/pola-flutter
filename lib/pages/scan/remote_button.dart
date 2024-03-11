import 'package:flutter/material.dart';
import 'package:pola_flutter/analytics/pola_analytics.dart';
import 'package:pola_flutter/models/donate.dart';
import 'package:url_launcher/url_launcher.dart';

class RemoteButtonState {
  final Donate? buttonDto;
  final String? code;

  RemoteButtonState(this.buttonDto, this.code);
}

class RemoteButton extends StatelessWidget {
  RemoteButton(this.state);

  final RemoteButtonState state;
  final PolaAnalytics _analytics = PolaAnalytics.instance();

  @override
  Widget build(BuildContext context) {
    Donate? buttonDto = state.buttonDto;
    String? code = state.code;
    if (buttonDto == null || buttonDto.showButton == false || code == null) {
      return Container();
    }
    Uri? url = Uri.tryParse(buttonDto.url);
    if (url == null) {
      return Container();
    }

    return Padding(
        padding: EdgeInsets.only(left: 8.0, top: 0.0, right: 8.0, bottom: 0.0),
        child: TextButton(
          style: ButtonStyle(
            minimumSize:
                MaterialStateProperty.all<Size>(Size(double.infinity, 0)),
            backgroundColor: MaterialStateProperty.all<Color>(Colors.red),
            foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
          ),
          onPressed: () async {
            _analytics.donateOpened(code);
            launchUrl(
              url,
              mode: LaunchMode.externalApplication,
            );
          },
          child: Text(buttonDto.title),
        ));
  }
}
