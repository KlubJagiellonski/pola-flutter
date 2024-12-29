import 'package:flutter/material.dart';
import 'package:pola_flutter/analytics/pola_analytics.dart';
import 'package:pola_flutter/theme/assets.gen.dart';
import 'package:pola_flutter/theme/colors.dart';
import 'package:url_launcher/url_launcher.dart';

class RemoteButtonState {
  final String title;
  final Uri uri;
  final String code;

  RemoteButtonState({required this.title, required this.uri, required this.code});
}

class RemoteButton extends StatelessWidget {
  final RemoteButtonState state;
  final GestureTapCallback onCloseTap;

  RemoteButton(this.state, this.onCloseTap);

  @override
  Widget build(BuildContext context) {
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
                PolaAnalytics.instance().donateOpened(state.code);
                await launchUrl(
                  state.uri,
                  mode: LaunchMode.externalApplication,
                );
              },
              child: Text(state.title),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(right: 8.0),
            child: GestureDetector(
              onTap: onCloseTap,
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
