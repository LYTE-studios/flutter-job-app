import 'package:dio/dio.dart';
import 'package:hive/hive.dart';
import 'package:logger/logger.dart';

class ApiService {
  late Dio dio;
  final Logger logger = Logger();

  ApiService() {
    BaseOptions options = BaseOptions(
      baseUrl: _getBaseUrl(),
      connectTimeout: const Duration(seconds: 30), // Increased from 10 to 30
      receiveTimeout: const Duration(seconds: 30), // Increased from 10 to 30
      sendTimeout: const Duration(seconds: 30), // Added send timeout
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
    );
    dio = Dio(options);
    _setupInterceptors();
  }

  static Future<Box> _getTokenBox() async {
    return await Hive.openBox('tokens');
  }

  static Future<Map<String, String?>> getTokens() async {
    Box box = await _getTokenBox();

    final token = await box.get('access_token');
    final refreshToken = await box.get('refresh_token');

    return {'access_token': token, 'refresh_token': refreshToken};
  }

  Future<void> setTokens(String accessToken, String refreshToken) async {
    Box box = await _getTokenBox();

    await box.put('access_token', accessToken);
    await box.put('refresh_token', refreshToken);
  }

  Future<void> clearTokens() async {
    Box box = await _getTokenBox();

    await box.delete('access_token');
    await box.delete('refresh_token');
  }

  static String _getBaseUrl() {
    return const String.fromEnvironment(
      'BASE_URL',
      defaultValue: "https://api.jobr.lytestudios.be/api/",
    );
  }

  void _setupInterceptors() {
    dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) async {
        final token = (await getTokens())['access_token'];
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
    final token = (await getTokens())['access_token'];
    final options = Options(
      method: requestOptions.method,
      headers: {
        ...requestOptions.headers,
        'Authorization': 'Bearer $token',
      },
    );

    dio.interceptors.clear();

    Response response = await dio.request<dynamic>(
      requestOptions.path,
      data: requestOptions.data,
      options: options,
    );

    _setupInterceptors();

    if (response.statusCode == 401) {
      await clearTokens();
      throw Exception("Token expired");
    }

    return response;
  }

  Future<bool> _refreshToken() async {
    try {
      final refreshToken = (await getTokens())['refresh_token'];
      if (refreshToken == null) return false;

      dio.interceptors.clear();

      final response = await dio.post('token/refresh/', data: {
        'refresh': refreshToken,
      });

      _setupInterceptors();

      if (response.statusCode == 200) {
        await setTokens(response.data['access'], response.data['refresh']);
        return true;
      }

      await clearTokens();
      return false;
    } catch (e) {
      logger.e('Error refreshing token: $e');
      return false;
    }
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
