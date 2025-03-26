import 'package:flutter/material.dart';
import 'package:pola_flutter/analytics/pola_analytics.dart';
import 'package:pola_flutter/theme/assets.gen.dart';
import 'package:pola_flutter/theme/colors.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:equatable/equatable.dart';

class RemoteButtonState extends Equatable {
  final String title;
  final Uri uri;
  final String code;

  RemoteButtonState({
    required this.title,
    required this.uri,
    required this.code,
  });

  @override
  List<Object?> get props => [title, uri, code];
}

class RemoteButton extends StatelessWidget {
  final RemoteButtonState state;
  final GestureTapCallback onCloseTap;

  RemoteButton(this.state, this.onCloseTap);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(
          left: 16.0, right: 16.0, top: 9.0, bottom: 11.0),
      decoration: BoxDecoration(
        color: AppColors.defaultRed,
        borderRadius: BorderRadius.circular(25),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 11.0),
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
            GestureDetector(
              onTap: onCloseTap,
              child: Container(
                padding: const EdgeInsets.all(8.0),
                child: Assets.scan.closeSmall.svg(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
