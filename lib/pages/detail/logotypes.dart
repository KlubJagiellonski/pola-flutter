import 'package:flutter/material.dart';
import 'package:pola_flutter/analytics/pola_analytics.dart';
import 'package:pola_flutter/models/search_result.dart';
import 'package:pola_flutter/theme/colors.dart';
import 'package:url_launcher/url_launcher.dart';

class Logotype {
  final String imageUrl;
  final String? websiteUrl;

  Logotype(this.imageUrl, this.websiteUrl);
}

class Logotypes extends StatelessWidget {
  final List<Logotype> logotypes;
  final SearchResult searchResult;
  final PolaAnalytics analytics = PolaAnalytics.instance();

  Logotypes({required this.logotypes, required this.searchResult});

  @override
  Widget build(BuildContext context) {
    if (logotypes.isEmpty) {
      return Container();
    }
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: logotypes.map((logotype) {
          return GestureDetector(
            onTap: () {
              final url = logotype.websiteUrl;
              if (url == null) return;
              final Uri? uri = Uri.tryParse(url);
              if (uri == null) return;

              analytics.readMore(searchResult, url);
              launchUrl(
                uri,
                mode: LaunchMode.externalApplication,
              );
            },
            child: Padding(
              padding: EdgeInsets.all(8.0),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  color: AppColors.textField.withAlpha((0.7 * 255).toInt()),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity( 0.3),
                      spreadRadius: 1,
                      blurRadius: 5,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: _LogoView(logotype.imageUrl),
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}

class _LogoView extends StatelessWidget {
  _LogoView(this.url);

  final String url;

  @override
  Widget build(BuildContext context) {
    return Image.network(url, height: 60.0, fit: BoxFit.contain);
  }
}
