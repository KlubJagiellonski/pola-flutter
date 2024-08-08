import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:pola_flutter/i18n/strings.g.dart';

class ExpandableText extends StatefulWidget {
  final String text;
  ExpandableText(this.text);

  @override
  _ExpandableTextState createState() => _ExpandableTextState();
}

class _ExpandableTextState extends State<ExpandableText> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    final link = TextSpan(
      style: TextStyle(
        color: Color(0xFF898989),
        fontSize: 11.0,
        fontWeight: FontWeight.w700,
        fontFamily: 'Lato',
      ),
      text: isExpanded ? t.companyScreen.seeLess : t.companyScreen.seeMore,
      recognizer: TapGestureRecognizer()
        ..onTap = () {
          setState(() {
            isExpanded = !isExpanded;
          });
        },
    );

    return LayoutBuilder(
      builder: (context, constraints) {
        final textSpan = TextSpan(
          text: widget.text,
          style: TextStyle(
            color: Colors.black,
            fontSize: 11.0,
            fontWeight: FontWeight.w400,
            fontFamily: 'Lato',
          ),
        );

        final textPainter = TextPainter(
          text: textSpan,
          maxLines: isExpanded ? null : 3,
          ellipsis: '...',
          textDirection: TextDirection.ltr,
        );

        textPainter.layout(
          minWidth: constraints.minWidth,
          maxWidth: constraints.maxWidth,
        );

        final linkTextPainter = TextPainter(
          text: link,
          textDirection: TextDirection.ltr,
        );

        linkTextPainter.layout(
          minWidth: constraints.minWidth,
          maxWidth: constraints.maxWidth,
        );

        if (!isExpanded && textPainter.didExceedMaxLines) {
          final pos = textPainter.getPositionForOffset(Offset(
            textPainter.width - linkTextPainter.width,
            textPainter.height,
          ));
          final end = textPainter.getOffsetBefore(pos.offset);
          final text = TextSpan(
            text: widget.text.substring(0, end),
            style: TextStyle(color: Colors.black),
            children: [link],
          );

          return RichText(
            text: text,
          );
        } else {
          return RichText(
            text: TextSpan(
              text: widget.text,
              style: TextStyle(color: Colors.black),
              children: [if (isExpanded) link],
            ),
          );
        }
      },
    );
  }
}
