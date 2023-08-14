import 'package:mockito/mockito.dart';
import 'package:pola_flutter/analytics/analytics_about_row.dart';
import 'package:pola_flutter/analytics/analytics_provider.dart';
import 'package:pola_flutter/analytics/pola_analytics.dart';
import 'package:test/test.dart';

import 'mock_analytics_provider.dart';

void main() {
  group('PolaAnalytics aboutOpened', () {
    late AnalyticsProvider mockAnalyticsProvider;
    late PolaAnalytics polaAnalytics;

    setUp(() {
      mockAnalyticsProvider = MockAnalyticsProvider();
      polaAnalytics = PolaAnalytics(provider: mockAnalyticsProvider);
    });

    test('should send item when row is menu', () {
      polaAnalytics.aboutOpened(AnalyticsAboutRow.menu);

      verify(mockAnalyticsProvider.logEvent(
        'menu_item_opened',
        {
          'item': 'About Menu'
        }
      )).called(1);
    });

    test('should send item when row is aboutKJ', () {
      polaAnalytics.aboutOpened(AnalyticsAboutRow.aboutKJ);

      verify(mockAnalyticsProvider.logEvent(
        'menu_item_opened',
        {
          'item': 'O Klubie Jagiellońskim'
        }
      )).called(1);
    });

  });
}