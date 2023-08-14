import 'package:pola_flutter/analytics/analytics_about_row.dart';

import '../models/search_result.dart';
import 'analytics_event_name.dart';
import 'analytics_barcode_source.dart';
import 'analytics_parameters.dart';
import 'analytics_provider.dart';

class PolaAnalytics {
  final AnalyticsProvider provider;

  PolaAnalytics({required this.provider});

  PolaAnalytics.instance() : provider = ConsoleAnalyticsProvider();

  void barcodeScanned(String barcode, AnalyticsBarcodeSource type) {
    _logEvent(
      AnalyticsEventName.scanCode,
      AnalyticsScanCodeParameters(code: barcode, source: type.name).toJson()
     );
  }

  void searchResultReceived(SearchResult result) {
    _logEvent(
      AnalyticsEventName.companyReceived,
      AnalyticsProductResultParameters(
        code: result.code, 
        company: result.name, 
        productId: result.productId != null ? result.productId.toString() : null
        ).toJson()
    );
  }

    void opensCard(SearchResult result) {
    _logEvent(
      AnalyticsEventName.cardOpened,
      AnalyticsProductResultParameters(
        code: result.code, 
        company: result.name, 
        productId: result.productId != null ? result.productId.toString() : null
        ).toJson()
    );
  }

  void donateOpened(String? barcode) {
    _logEvent(
      AnalyticsEventName.donateOpened,
      AnalyticsProductResultParameters(code: barcode).toJson()
    );
  }

  void aboutOpened(AnalyticsAboutRow row) {
    _logEvent(
      AnalyticsEventName.menuItemOpened,
      AnalyticsAboutParameters(item: row.name).toJson()
    );
  }

  void _logEvent(AnalyticsEventName name, [Map<String, dynamic>? parameters]) {
    provider.logEvent(name.name, parameters);
  }

}
