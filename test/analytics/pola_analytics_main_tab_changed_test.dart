import 'package:mockito/mockito.dart';
import 'package:pola_flutter/analytics/analytics_main_tab.dart';
import 'package:pola_flutter/analytics/analytics_provider.dart';
import 'package:pola_flutter/analytics/pola_analytics.dart';
import 'package:test/test.dart';

import 'mock_analytics_provider.dart';

void main() {
  group('PolaAnalytics mainTabChanged', () {
    late AnalyticsProvider mockAnalyticsProvider;
    late PolaAnalytics polaAnalytics;

    setUp(() {
      mockAnalyticsProvider = MockAnalyticsProvider();
      polaAnalytics = PolaAnalytics(provider: mockAnalyticsProvider);
    });

    test('should send tab when tab is news', () {
      polaAnalytics.mainTabChanged(AnalyticsMainTab.news);

      verify(mockAnalyticsProvider.logEvent(
        'main_tab_changed',
        {'tab': 'News_feed'}
      )).called(1);
    });

    test('should send tab when tab is scanner', () {
      polaAnalytics.mainTabChanged(AnalyticsMainTab.scanner);

      verify(mockAnalyticsProvider.logEvent(
        'main_tab_changed',
        {'tab': 'Scanner'}
      )).called(1);
    });
  
  });
}
