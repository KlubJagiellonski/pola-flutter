import 'package:flutter/material.dart';

class LinearProgressIndicatorWithText extends StatelessWidget {
  LinearProgressIndicatorWithText(this.progress, this.text);

  final String text;
  final double progress;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        LinearProgressIndicator(
          minHeight: 22.0,
          value: progress / 100.toDouble(),
          backgroundColor: Colors.grey,
          semanticsLabel: 'Linear progress indicator',
        ),
        Align(
          alignment: Alignment.centerRight,
          child: Padding(
              padding: EdgeInsets.only(right: 16.0),
              child: Text(
                text,
                style: TextStyle(color: Colors.white),
              )),
        )
      ],
    );
  }
}
