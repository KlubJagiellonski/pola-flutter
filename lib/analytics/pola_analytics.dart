import 'analytics_event_name.dart';
import 'analytics_barcode_source.dart';
import 'analytics_parameters.dart';
import 'analytics_provider.dart';

class PolaAnalytics {
  final AnalyticsProvider provider;

  PolaAnalytics({required this.provider});

  void barcodeScanned(String barcode, AnalyticsBarcodeSource type) {
    
    _logEvent(
      AnalyticsEventName.scanCode,
      AnalyticsScanCodeParameters(code: barcode, source: type.name).toJson()
     );
  }

  void _logEvent(AnalyticsEventName name, [Map<String, dynamic>? parameters]) {
    provider.logEvent(name.name, parameters);
  }

}
