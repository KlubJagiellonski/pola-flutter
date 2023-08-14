import 'package:mockito/mockito.dart';
import 'package:pola_flutter/analytics/analytics_provider.dart';
import 'package:pola_flutter/analytics/pola_analytics.dart';
import 'package:test/test.dart';

import 'mock_analytics_provider.dart';

void main() {
  group('PolaAnalytics', () {
    late AnalyticsProvider mockAnalyticsProvider;
    late PolaAnalytics polaAnalytics;

    setUp(() {
      mockAnalyticsProvider = MockAnalyticsProvider();
      polaAnalytics = PolaAnalytics(provider: mockAnalyticsProvider);
    });

    test('polasFriendsOpened should send polasFriends event name', () {
      polaAnalytics.polasFriendsOpened();

      verify(mockAnalyticsProvider.logEvent(
        'polas_friends',
        null
      )).called(1);
    });

    test('aboutPolaOpened should send aboutPola event name', () {
      polaAnalytics.aboutPolaOpened();

      verify(mockAnalyticsProvider.logEvent(
        'about_pola',
        null
      )).called(1);
    });

  });
}
