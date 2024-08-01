import 'package:firebase_analytics/firebase_analytics.dart';

abstract class AnalyticsProvider {
  void logEvent(String name, [Map<String, dynamic>? parameters]);
}

class FirebaseAnalyticsProvider implements AnalyticsProvider {
  final FirebaseAnalytics _analytics = FirebaseAnalytics.instance;

  @override
  void logEvent(String name, [Map<String, dynamic>? parameters]) {
    Map<String, Object>? objectMap = parameters?.map((key, value) => MapEntry(key, value as Object));
    _analytics.logEvent(name: name, parameters: objectMap);
  }
}

class ConsoleAnalyticsProvider implements AnalyticsProvider {
  @override
  void logEvent(String name, [Map<String, dynamic>? parameters]) {
    print('Analytics event: $name, parameters: $parameters');
  }
}
