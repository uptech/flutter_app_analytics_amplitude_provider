import 'dart:convert';

import 'package:flutter_app_analytics/flutter_app_analytics.dart';
import 'package:flutter_app_analytics_amplitude_provider/src/amplitude_dio_client.dart';

class AmplitudeProvider implements AnalyticsProvider {
  String apiKey;
  AmplitudeDioClient client = AmplitudeDioClient();
  AmplitudeIdentification? _amplitudeIdentification;

  AmplitudeProvider({required this.apiKey});

  Future<void> identify(AnalyticsIdentification properties) async {
    this._amplitudeIdentification = AmplitudeIdentification(properties);
    final requestData = this._amplitudeIdentification!.toJson();
    return await client.identify(data: {
      'api_key': this.apiKey,
      'identification': jsonEncode(requestData),
    });
  }

  Future<void> trackEvent(AnalyticsEvent event) async {
    final ip = await client.getIpAddress();
    return await client.trackEvents(
      apiKey: this.apiKey,
      events: [_generateJsonEvent(event, ip)],
    );
  }

  Future<void> trackEvents(List<AnalyticsEvent> events) async {
    final ip = await client.getIpAddress();
    return await client.trackEvents(
      apiKey: this.apiKey,
      events: events.map((e) => _generateJsonEvent(e, ip)).toList(),
    );
  }

  Map<String, dynamic> _generateJsonEvent(AnalyticsEvent event, String ip) {
    return {
      'user_id': this._amplitudeIdentification?.properties.userId,
      'device_id': this._amplitudeIdentification?.properties.deviceId,
      'event_type': event.name,
      'event_properties': event.properties,
      'time': DateTime.now().millisecondsSinceEpoch,
      'ip': ip,
    };
  }
}

class AmplitudeIdentification {
  AnalyticsIdentification properties;

  AmplitudeIdentification(this.properties);

  Map toJson() => {
        'user_id': this.properties.userId,
        'device_id': this.properties.deviceId,
        'os_name': this.properties.osName,
        'os_version': this.properties.osVersion,
        'app_version': this.properties.appVersion,
        'device_model': this.properties.deviceModel,
        'device_manufacturer': this.properties.deviceManufacturer,
        'device_brand': this.properties.deviceBrand,
        'platform': this.properties.platform,
        'user_properties': this.properties.userProperties,
      };
}
