import 'package:dio/dio.dart';
import 'package:flutter_exam/data/services/api_service.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:logger/logger.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';

import 'widget_test.mocks.dart';

@GenerateMocks([Dio, FlutterSecureStorage, Logger])
void main() {
  late MockDio mockDio;
  late MockFlutterSecureStorage mockStorage;
  late MockLogger mockLogger;
  late ApiService apiService;

  setUp(() {
    mockDio = MockDio();
    mockStorage = MockFlutterSecureStorage();
    mockLogger = MockLogger();

    apiService = ApiService(secureStorage: mockStorage);
    apiService.dio = mockDio; // Inject mocked Dio
  });

  group('ApiService - GET API', () {
    test('Successful GET request', () async {
      final responsePayload = {'data': 'test'};
      final response = Response(
        data: responsePayload,
        statusCode: 200,
        requestOptions: RequestOptions(path: '/test'),
      );

      // Mock Dio GET response
      when(mockDio.get('/test', queryParameters: anyNamed('queryParameters')))
          .thenAnswer((_) async => response);

      // Call getApi
      final result = await apiService.getApi('/test');

      // Verify and assert
      expect(result.statusCode, 200);
      expect(result.data, responsePayload);
      verify(mockDio.get('/test', queryParameters: anyNamed('queryParameters')))
          .called(1);
    });

    test('GET request throws error', () async {
      // Mock Dio GET error
      when(mockDio.get(any, queryParameters: anyNamed('queryParameters')))
          .thenThrow(DioError(
        requestOptions: RequestOptions(path: '/test'),
        error: 'Network Error',
      ));

      // Expect an exception
      expect(() => apiService.getApi('/test'), throwsA(isA<DioError>()));

      verify(mockDio.get('/test', queryParameters: anyNamed('queryParameters')))
          .called(1);
    });
  });
}
