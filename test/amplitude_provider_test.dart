import 'package:flutter_app_analytics/src/analytics_event.dart';
import 'package:flutter_app_analytics/src/analytics_identification.dart';
import 'package:flutter_app_analytics_amplitude_provider/flutter_app_analytics_amplitude_provider.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'test_mocks.dart';

void main() {
  group('AmplitudeProvider -', () {
    final MockAmplitudeDioClient mockClient = MockAmplitudeDioClient();
    final AmplitudeProvider provider = AmplitudeProvider(apiKey: 'abc123');
    provider.client = mockClient;

    setUp(() {
      when(() => mockClient.identify(data: any(named: 'data')))
          .thenAnswer((_) async => {});

      when(() => mockClient.getIpAddress())
          .thenAnswer((_) async => Future.value('1.2.3.4'));

      when(() => mockClient.trackEvents(
            apiKey: any(named: 'apiKey'),
            events: any(named: 'events'),
          )).thenAnswer((_) async => {});
    });

    group('Identification -', () {
      test('Should identify to Amplitude', () async {
        AnalyticsIdentification props = AnalyticsIdentification();
        props.userId = 'foo';

        await provider.identify(props);

        verify(() => mockClient.identify(data: any(named: 'data'))).called(1);
      });
    });

    group('Tracking -', () {
      test('Should send event to Amplify', () async {
        await provider.trackEvent(AnalyticsEvent(name: 'test'));

        verify(() => mockClient.getIpAddress()).called(1);
        verify(() => mockClient.trackEvents(
              apiKey: any(named: 'apiKey'),
              events: any(named: 'events'),
            )).called(1);
      });
    });
  });
}
