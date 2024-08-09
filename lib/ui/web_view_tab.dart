import 'package:flutter/material.dart';
import 'package:pola_flutter/pages/web/web_view_page.dart';

class WebViewTab extends StatelessWidget {
  final String title;
  final String url;

  WebViewTab({Key? key, required this.title, required this.url})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          title,
          style: TextStyle(
            fontWeight: FontWeight.w700,
            fontFamily: "lato",
            color: Color(0xFF1C1B1F),
          ),
        ),
      ),
      body: Center(
        child: WebViewPage(url: url),
      ),
    );
  }
}
