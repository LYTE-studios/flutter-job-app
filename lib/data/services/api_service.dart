import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hive/hive.dart';
import 'package:logger/logger.dart';

class ApiService {
  late Dio dio;
  final FlutterSecureStorage storage;
  final Logger logger = Logger();

  ApiService({FlutterSecureStorage? secureStorage})
      : storage = secureStorage ?? const FlutterSecureStorage() {
    BaseOptions options = BaseOptions(
      baseUrl: _getBaseUrl(),
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

  static String _getBaseUrl() {
    return const String.fromEnvironment('BASE_URL',
        defaultValue: "https://api.jobr.lytestudios.be/api/");
  }

  void _setupInterceptors() {
    dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) async {
        final token = await storage.read(key: 'access_token');
        if (token != null) {
          options.headers['Authorization'] = 'Bearer $token';
        }
        logger.d("Request: ${options.method} ${options.path}");
        logger.d("Headers: ${options.headers}");
        return handler.next(options);
      },
      onError: (DioException error, handler) async {
        if (error.response?.statusCode == 401) {
          final refreshed = await _refreshToken();
          if (refreshed) {
            return handler.resolve(await _retry(error.requestOptions));
          }
        }
        logger.e('Error: ${error.message}');
        return handler.next(error);
      },
    ));
  }

  Future<Response<dynamic>> _retry(RequestOptions requestOptions) async {
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
      final refreshToken = await storage.read(key: 'refresh_token');
      if (refreshToken == null) return false;

      final response = await dio.post('token/refresh/', data: {
        'refresh': refreshToken,
      });

      if (response.statusCode == 200) {
        await setTokens(response.data['access'], response.data['refresh']);
        return true;
      }
      return false;
    } catch (e) {
      logger.e('Error refreshing token: $e');
      return false;
    }
  }

  Future<void> setTokens(String accessToken, String refreshToken) async {
    await storage.write(key: 'access_token', value: accessToken);
    await storage.write(key: 'refresh_token', value: refreshToken);
  }

  Future<void> clearTokens() async {
    await storage.delete(key: 'access_token');
    await storage.delete(key: 'refresh_token');
  }

  static String _formatUrl(String url) {
    if (url.endsWith('/')) {
      url = url.substring(0, url.length - 1);
    }

    return url;
  }

  /// Common `getApi` method
  Future<Response<dynamic>> getApi(
    String endpoint, {
    Map<String, dynamic>? queryParameters,
    Duration? cacheDuration,
  }) async {
    Box? box;

    if (cacheDuration != null) {
      box = await Hive.openBox<dynamic>('cache');

      if (box.containsKey(endpoint)) {
        Map<dynamic, dynamic> data = box.get(endpoint);

        if (data['created'] == null ||
            (DateTime.now().millisecondsSinceEpoch -
                    ((data['created'] as int?) ?? 0) >
                cacheDuration.inMilliseconds)) {
          await box.delete(endpoint);
        } else {
          return Response(
            data: data['data'],
            requestOptions: RequestOptions(path: endpoint),
          );
        }
      }
    }

    try {
      Response response = await dio.get(
        _formatUrl(endpoint),
        queryParameters: queryParameters,
      );

      if (box != null) {
        box.put(
          endpoint,
          {
            'created': DateTime.now().millisecondsSinceEpoch,
            'data': response.data,
          },
        );
      }

      return response;
    } catch (e) {
      logger.e('GET API Error: $e');
      rethrow;
    }
  }

  /// Common `postApi` method
  Future<Response<dynamic>> postApi(
    String endpoint, {
    Map<String, dynamic>? data,
  }) async {
    try {
      return await dio.post(
        _formatUrl(endpoint),
        data: data,
      );
    } catch (e) {
      logger.e('POST API Error: $e');
      rethrow;
    }
  }
}
