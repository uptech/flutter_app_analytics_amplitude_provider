import 'package:amplitude_flutter/amplitude.dart';
import 'package:flutter_app_analytics/flutter_app_analytics.dart';

class AmplitudeProvider implements AnalyticsProvider {
  @override
  List<String> allowedUserProperties;

  final Amplitude _amplitude = Amplitude.getInstance();

  AmplitudeProvider(
      {required String apiKey,
      String? userId,
      bool? trackUserSession,
      List<String>? allowedProperties})
      : allowedUserProperties = allowedProperties ?? [] {
    _amplitude.init(apiKey, userId: userId);
    _amplitude.trackingSessionEvents(trackUserSession ?? true);
  }

  Future<void> identify({
    String? userId,
    Map<String, dynamic>? properties,
  }) async {
    if (userId != null) {
      await _amplitude.setUserId(userId);
    }

    if (properties != null) {
      await _amplitude.setUserProperties(properties);
    }
  }

  Future<void> trackEvent(AnalyticsEvent event) async {
    await _amplitude.logEvent(event.name, eventProperties: event.properties);
  }

  Future<void> trackEvents(List<AnalyticsEvent> events) async {
    await Future.forEach<AnalyticsEvent>(events, (event) => trackEvent(event));
  }
}
