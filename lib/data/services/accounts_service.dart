import 'package:dio/dio.dart';
import 'package:flutter_exam/data/services/api_service.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AccountsService {
  final ApiService apiService;
  final FlutterSecureStorage storage;

  // Updated constructor with optional storage parameter
  AccountsService(this.apiService, [FlutterSecureStorage? secureStorage])
      : storage = secureStorage ?? FlutterSecureStorage();

  Future<Map<String, dynamic>> login(String username, String password) async {
    try {
      // Request tokens using the TokenObtainPair endpoint
      final response = await apiService.dio.post(
        "token/",
        data: {
          "username": username,
          "password": password,
        },
      );

      // Store tokens locally
      await storage.write(
        key: 'access_token',
        value: response.data['access'],
      );
      await storage.write(
        key: 'refresh_token',
        value: response.data['refresh'],
      );

      // Call login endpoint (if necessary for further processing)
      final loginResponse = await apiService.dio.post(
        "/accounts/login/",
        data: {
          "username": username,
          "password": password,
        },
        options: Options(
          headers: {
            'Authorization': 'Bearer ${response.data['access']}',
          },
        ),
      );

      return loginResponse.data;
    } on DioError catch (e) {
      if (e.response?.statusCode == 401) {
        throw Exception("Invalid username or password");
      }
      throw Exception("Login failed: ${e.message}");
    }
  }

  // Function to register an employee
  Future<Map<String, dynamic>> registerByEmployee(
      Map<String, dynamic> employeeData) async {
    try {
      // Retrieve access token from secure storage
      final accessToken = await storage.read(key: 'access_token');
      if (accessToken == null) {
        throw Exception("Access token not found. Please log in again.");
      }

      // Make the API call with the token in the Authorization header
      final response = await apiService.dio.post(
        "/accounts/register/employee/",
        data: employeeData,
        options: Options(
          headers: {
            'Authorization': 'Bearer $accessToken',
          },
        ),
      );
      return response.data;
    } on DioError catch (e) {
      if (e.response?.statusCode == 400) {
        throw Exception("Validation error: ${e.response?.data}");
      }
      throw Exception("Failed to register employee: ${e.message}");
    }
  }

  Future<Map<String, dynamic>> registerByEmployer(
      Map<String, dynamic> employerData) async {
    try {
      // Retrieve access token from secure storage
      final accessToken = await storage.read(key: 'access_token');
      if (accessToken == null) {
        throw Exception("Access token not found. Please log in again.");
      }

      // Make the API call with the token in the Authorization header
      final response = await apiService.dio.post(
        "/accounts/register/employer/",
        data: employerData,
        options: Options(
          headers: {
            'Authorization': 'Bearer $accessToken',
          },
        ),
      );
      return response.data;
    } on DioError catch (e) {
      if (e.response?.statusCode == 400) {
        throw Exception("Validation error: ${e.response?.data}");
      }
      throw Exception("Failed to register employer: ${e.message}");
    }
  }
}
