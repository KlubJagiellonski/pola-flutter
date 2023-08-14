import 'package:mockito/mockito.dart';
import 'package:pola_flutter/analytics/analytics_provider.dart';
import 'package:pola_flutter/analytics/pola_analytics.dart';
import 'package:test/test.dart';

import 'mock_analytics_provider.dart';

void main() {
  group('PolaAnalytics donateOpened', () {
    late AnalyticsProvider mockAnalyticsProvider;
    late PolaAnalytics polaAnalytics;

    setUp(() {
      mockAnalyticsProvider = MockAnalyticsProvider();
      polaAnalytics = PolaAnalytics(provider: mockAnalyticsProvider);
    });

    test('should send code when code passed', () {
      polaAnalytics.donateOpened("12345");

      verify(mockAnalyticsProvider.logEvent(
        'donate_opened',
        {
          'code': '12345'
        }
      )).called(1);
    });

    test('should send empty parameters when code is null', () {
      polaAnalytics.donateOpened(null);

      verify(mockAnalyticsProvider.logEvent(
        'donate_opened',
        {}
      )).called(1);
    });

  });
}
