import 'package:mockito/mockito.dart';
import 'package:pola_flutter/analytics/analytics_provider.dart';
import 'package:pola_flutter/analytics/pola_analytics.dart';
import 'package:pola_flutter/models/search_result.dart';
import 'package:test/test.dart';

import 'mock_analytics_provider.dart';

SearchResult _testResult({String? code, String? name, int? productId}) {
  return SearchResult(
    code: code,
    name: name,
    productId: productId, 
    cardType: '',
    companies: [],
    donate: null, 
    report: null
  );
}

void main() {
  group('PolaAnalytics searchResultReceived', () {
    late AnalyticsProvider mockAnalyticsProvider;
    late PolaAnalytics polaAnalytics;

    setUp(() {
      mockAnalyticsProvider = MockAnalyticsProvider();
      polaAnalytics = PolaAnalytics(provider: mockAnalyticsProvider);
    });

    test('should send code, company and productId when result contain these values', () {
      final result = _testResult(code: '12345', name: 'Test company', productId: 123);

      polaAnalytics.searchResultReceived(result);

      verify(mockAnalyticsProvider.logEvent(
        'company_received',
        {
          'code': '12345',
          'company': 'Test company',
          'product_id': '123',
        }
      )).called(1);

    });

    test('should send code when result contain this value', () {
      final result = _testResult(code: 'code9');

      polaAnalytics.searchResultReceived(result);

      verify(mockAnalyticsProvider.logEvent(
        'company_received',
        {
          'code': 'code9'
        }
      )).called(1);

    });

    test('should send company when result contain this value', () {
      final result = _testResult(name: 'Test company');

      polaAnalytics.searchResultReceived(result);

      verify(mockAnalyticsProvider.logEvent(
        'company_received',
        {
          'company': 'Test company'
        }
      )).called(1);
    });

        test('should send productId when result contain this value', () {
      final result = _testResult(productId: 123);
      polaAnalytics.searchResultReceived(result);

      verify(mockAnalyticsProvider.logEvent(
        'company_received',
        {
          'product_id': '123'
        }
      )).called(1);
        });

  });
}
