import 'package:flutter/material.dart';
import 'package:pola_flutter/analytics/pola_analytics.dart';
import 'package:pola_flutter/models/donate.dart';
import 'package:pola_flutter/theme/assets.gen.dart';
import 'package:pola_flutter/theme/colors.dart';
import 'package:url_launcher/url_launcher.dart';

class RemoteButtonState {
  final Donate? buttonDto;
  final String? code;

  RemoteButtonState(this.buttonDto, this.code);
}

class RemoteButton extends StatefulWidget {
  final RemoteButtonState state;

  RemoteButton(this.state);

  @override
  _RemoteButtonState createState() => _RemoteButtonState();
}

class _RemoteButtonState extends State<RemoteButton> {
  bool _isVisible = true;

  @override
  Widget build(BuildContext context) {
    if (!_isVisible) {
      return Container();
    }

    Donate? buttonDto = widget.state.buttonDto;
    String? code = widget.state.code;
    if (buttonDto == null || buttonDto.showButton == false || code == null) {
      return Container();
    }
    Uri? url = Uri.tryParse(buttonDto.url);
    if (url == null) {
      return Container();
    }

    return Container(
      width: 328,
      height: 40,
      decoration: BoxDecoration(
        color: AppColors.defaultRed,
        borderRadius: BorderRadius.circular(25),
      ),
      child: Row(
        children: [
          Expanded(
            child: TextButton(
              style: ButtonStyle(
                foregroundColor: WidgetStateProperty.all<Color>(Colors.white),
              ),
              onPressed: () async {
                PolaAnalytics.instance().donateOpened(code);
                await launchUrl(
                  url,
                  mode: LaunchMode.externalApplication,
                );
              },
              child: Text(buttonDto.title),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(right: 8.0),
            child: GestureDetector(
              onTap: () {
                setState(() {
                  _isVisible = false;
                });
              },
              child: Assets.scan.closeSmall.svg(
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
