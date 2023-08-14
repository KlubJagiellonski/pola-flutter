import 'package:mockito/mockito.dart';
import 'package:pola_flutter/analytics/analytics_barcode_source.dart';
import 'package:pola_flutter/analytics/analytics_provider.dart';
import 'package:pola_flutter/analytics/pola_analytics.dart';
import 'package:test/test.dart';

import 'mock_analytics_provider.dart';

void main() {
  group('PolaAnalytics barcodeScanned', () {
    late AnalyticsProvider mockAnalyticsProvider;
    late PolaAnalytics polaAnalytics;

    setUp(() {
      mockAnalyticsProvider = MockAnalyticsProvider();
      polaAnalytics = PolaAnalytics(provider: mockAnalyticsProvider);
    });

    test('should send source camera', () {
      polaAnalytics.barcodeScanned('12345', AnalyticsBarcodeSource.camera);

      verify(mockAnalyticsProvider.logEvent(
        'scan_code',
        {
          'code': '12345',
          'source': 'Camera',
        }
      )).called(1);
    });

    test('should send source keyboard', () {
      polaAnalytics.barcodeScanned('12345', AnalyticsBarcodeSource.keyboard);

      verify(mockAnalyticsProvider.logEvent(
        'scan_code',
        {
          'code': '12345',
          'source': 'Keyboard',
        }
      )).called(1);
    });

    test('should send code camera', () {
      polaAnalytics.barcodeScanned('properCode', AnalyticsBarcodeSource.camera);

      verify(mockAnalyticsProvider.logEvent(
        'scan_code',
        {
          'code': 'properCode',
          'source': 'Camera',
        }
      )).called(1);
    });
  });
}
