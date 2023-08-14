import '../models/search_result.dart';
import 'analytics_event_name.dart';
import 'analytics_barcode_source.dart';
import 'analytics_parameters.dart';
import 'analytics_provider.dart';

class PolaAnalytics {
  final AnalyticsProvider provider;

  PolaAnalytics({required this.provider});

  PolaAnalytics.instance() : provider = FirebaseAnalyticsProvider();

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

  void _logEvent(AnalyticsEventName name, [Map<String, dynamic>? parameters]) {
    provider.logEvent(name.name, parameters);
  }

}
