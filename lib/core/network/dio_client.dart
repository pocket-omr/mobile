import 'package:dio/dio.dart';
import 'api_constants.dart';
import 'token_manager.dart';

class DioClient {
  late Dio _dio;
  final TokenManager _tokenManager = TokenManager();

  DioClient() {
    _dio = Dio(
      BaseOptions(
        baseUrl: ApiConstants.baseUrl,
        connectTimeout: const Duration(seconds: 15),
        receiveTimeout: const Duration(seconds: 15),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      ),
    );

    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          final token = await _tokenManager.getAccessToken();
          if (token != null) {
            options.headers['Authorization'] = 'Bearer $token';
          }
          return handler.next(options);
        },
        onError: (DioException e, handler) async {
          if (e.response?.statusCode == 401) {
            // Ideally we handle token refresh here
            // But we will pass it down for now
          }
          return handler.next(e);
        },
      ),
    );
  }

  Dio get dio => _dio;
}
