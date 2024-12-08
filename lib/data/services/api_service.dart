import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class ApiService {
  late Dio dio;
  final FlutterSecureStorage
      storage; // Make storage public for reuse in other services

  ApiService({FlutterSecureStorage? secureStorage})
      : storage = secureStorage ?? FlutterSecureStorage() {
    // Use the provided storage or default to a new instance
    BaseOptions options = BaseOptions(
      baseUrl: "http://localhost:8000/api/", // Base API URL
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 10),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
    );
    dio = Dio(options);
    _setupInterceptors();
  }

  void _setupInterceptors() {
    dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) async {
        // Retrieve the access token from storage
        final token = await storage.read(key: 'access_token');
        if (token != null) {
          options.headers['Authorization'] = 'Bearer $token';
        }
        print("Request: ${options.method} ${options.path}");
        print("Headers: ${options.headers}");
        return handler.next(options);
      },
      onError: (DioError error, handler) async {
        // Handle token expiration and retry logic
        if (error.response?.statusCode == 401) {
          final refreshed = await _refreshToken();
          if (refreshed) {
            return handler.resolve(await _retry(error.requestOptions));
          }
        }
        return handler.next(error);
      },
    ));
  }

  Future<Response<dynamic>> _retry(RequestOptions requestOptions) async {
    // Retry the failed request with a refreshed token
    final token = await storage.read(key: 'access_token');
    final options = Options(
      method: requestOptions.method,
      headers: {
        ...requestOptions.headers,
        'Authorization': 'Bearer $token',
      },
    );

    return dio.request<dynamic>(
      requestOptions.path,
      data: requestOptions.data,
      options: options,
    );
  }

  Future<bool> _refreshToken() async {
    try {
      // Retrieve the refresh token from storage
      final refreshToken = await storage.read(key: 'refresh_token');
      if (refreshToken == null) return false;

      final response = await dio.post('token/refresh/', data: {
        'refresh': refreshToken,
      });

      if (response.statusCode == 200) {
        // Save the new access token to storage
        await storage.write(
          key: 'access_token',
          value: response.data['access'],
        );
        return true;
      }
      return false;
    } catch (e) {
      print('Error refreshing token: $e');
      return false;
    }
  }
}
