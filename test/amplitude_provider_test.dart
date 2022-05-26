import 'package:flutter_app_analytics/src/analytics_event.dart';
import 'package:flutter_app_analytics_amplitude_provider/flutter_app_analytics_amplitude_provider.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'test_mocks.dart';

void main() {
  setUpAll(() {
    registerFallbackValue(AnalyticsEvent(name: 'test'));
  });

  group('AmplitudeProvider -', () {
    final AmplitudeProvider provider = MockAmplitudeProvider();
    final testEvent = AnalyticsEvent(name: 'test');

    setUp(() {
      when(() => provider.identify(userId: any(named: 'userId')))
          .thenAnswer((_) async => {});
      when(() => provider.trackEvent(testEvent)).thenAnswer((_) async => {});
    });

    group('Tracking -', () {
      test('Should send event to Amplitude', () async {
        await provider.trackEvent(testEvent);

        verify(() => provider.trackEvent(testEvent)).called(1);
      });
    });
  });
}
