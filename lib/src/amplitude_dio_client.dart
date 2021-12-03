import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

class AmplitudeDioClient {
  Dio _dio = Dio();

  Future<void> identify({required Map<String, dynamic> data}) async {
    try {
      await _dio.post(
        'https://api.amplitude.com/identify',
        data: data,
        options: Options(
          headers: {
            Headers.contentTypeHeader: Headers.formUrlEncodedContentType,
          },
        ),
      );
    } on DioError catch (e) {
      debugPrint("======= [AmplifyHttpClient] Error in Identify call =======");
      debugPrint("Data: ${e.requestOptions.data}");
      debugPrint(e.message);

      if (e.response != null) {
        debugPrint(e.response!.data);
        debugPrint(e.response!.headers.toString());
      }
      debugPrint("==========================================================");
    }
  }

  Future<void> trackEvents({
    required String apiKey,
    required List<Map<String, dynamic>> events,
  }) async {
    try {
      await _dio.post('https://api2.amplitude.com/2/httpapi', data: {
        'api_key': apiKey,
        'events': events,
      });
    } on DioError catch (e) {
      debugPrint("====== [AmplifyHttpClient] Error in TrackEvent call ======");
      debugPrint(e.message);

      if (e.response != null) {
        debugPrint(e.response!.data);
        debugPrint(e.response!.headers.toString());
      }
      debugPrint("==========================================================");
    }
  }

  Future<String> getIpAddress() async {
    try {
      final response = await _dio.get('https://api.ipify.org?format=json');
      return response.data['ip'];
    } on DioError catch (e) {
      debugPrint("========== [AmplifyHttpClient] Error in IP fetch ==========");
      debugPrint(e.message);

      if (e.response != null) {
        debugPrint(e.response!.data);
        debugPrint(e.response!.headers.toString());
      }
      debugPrint("===========================================================");
      rethrow;
    }
  }
}
