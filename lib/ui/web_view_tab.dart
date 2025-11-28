import 'package:flutter/material.dart';
import 'package:pola_flutter/pages/web/web_view_page.dart';
import 'package:pola_flutter/theme/colors.dart';
import 'package:pola_flutter/theme/fonts.gen.dart';

class WebViewTab extends StatefulWidget {
  final String title;
  final String url;

  WebViewTab({Key? key, required this.title, required this.url})
      : super(key: key);

  @override
  State<WebViewTab> createState() => _WebViewTabState();
}

class _WebViewTabState extends State<WebViewTab> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.title,
          style: TextStyle(
            fontWeight: FontWeight.w700,
            fontFamily: FontFamily.lato,
            color: AppColors.text,
          ),
        ),
      ),
      body: Center(
        child: WebViewPage(
          url: widget.url,
        ),
      ),
    );
  }
}
