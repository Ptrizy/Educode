import 'package:dio/dio.dart';
import 'package:quiz/data/local/shared_preference/auth_preference.dart';
import 'logger.dart';

class DioClient {
  final Dio _dio = Dio();

  DioClient() {
    _dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) async {
        // header => token
        final token = await AuthPreference.getToken();
        if (token != null) {
          options.headers['Authorization'] = 'Bearer $token';
        }
        AppLogger.info('Request: ${options.method} ${options.path}');
        return handler.next(options);
      },
      onResponse: (response, handler) {
        AppLogger.info(
            'Response: ${response.statusCode} ${response.statusMessage}');
        return handler.next(response);
      },
      onError: (DioException e, handler) {
        AppLogger.error('Error: ${e.message}', e, e.stackTrace);
        return handler.next(e);
      },
    ));
  }

  Dio get dio => _dio;
}
