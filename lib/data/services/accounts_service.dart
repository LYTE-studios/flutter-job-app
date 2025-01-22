import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:jobr/core/routing/router.dart';
import 'package:jobr/data/models/user.dart';
import 'package:jobr/data/services/api_service.dart';
import 'package:jobr/features/authentication/screens/splash_screen.dart';

class AccountsService extends ApiService {
  // Updated constructor with optional storage parameter
  AccountsService([FlutterSecureStorage? secureStorage]);

  Future<void> _storeTokens(String accessToken, String refreshToken) async {
    await storage.write(key: 'access_token', value: accessToken);
    await storage.write(key: 'refresh_token', value: refreshToken);
  }

  Future<void> logout() async {
    await storage.deleteAll();

    router.pushReplacement(SplashScreen.route);
  }

  Future<UserType> checkAuthentication() async {
    final accessToken = await storage.read(key: 'access_token');
    final refreshToken = await storage.read(key: 'refresh_token');

    if (accessToken == null || refreshToken == null) {
      throw Exception("Access token not found. Please log in again.");
    }

    try {
      final response = await getApi(
        '/accounts/test-connection',
      );

      if (response.data['role'] == 'employee') {
        return UserType.employee;
      } else if (response.data['role'] == 'employer') {
        return UserType.employer;
      } else {
        throw Exception("User not authenticated");
      }
    } catch (e) {
      throw Exception("User not authenticated");
    }
  }

  Future<UserType> login(String username, String password) async {
    try {
      // Request tokens using the TokenObtainPair endpoint
      final response = await postApi(
        "/accounts/login",
        data: {
          "username": username,
          "password": password,
        },
      );

      _storeTokens(response.data['access'], response.data['refresh']);

      // Optional: Call login endpoint (if necessary for further processing)
      final loginResponse = await postApi(
        "/accounts/login",
        data: {
          "username": username,
          "password": password,
        },
      );

      loginResponse.data;

      if (loginResponse.data['role'] == 'employee') {
        return UserType.employee;
      } else if (loginResponse.data['role'] == 'employer') {
        return UserType.employer;
      } else {
        throw Exception("Login failed: No user role found");
      }
    } on DioException catch (e) {
      if (e.response?.statusCode == 401) {
        throw Exception("Invalid username or password");
      }
      throw Exception("Login failed: ${e.message}");
    }
  }

  // Function to register an employee
  Future<Map<String, dynamic>> register({
    required String email,
    required String password,
    required UserType userType,
  }) async {
    try {
      // Make the API call with the token in the Authorization header
      final response = await postApi(
        "/accounts/register",
        data: {
          'username': email,
          'email': email,
          'password': password,
          'role': userType.api(),
        },
      );

      _storeTokens(response.data['access'], response.data['refresh']);

      return response.data;
    } on DioException catch (e) {
      if (e.response?.statusCode == 400) {
        throw Exception("Validation error: ${e.response?.data}");
      }
      throw Exception("Failed to register user: ${e.message}");
    }
  }

  // Function to register an employee
  Future<Map<String, dynamic>> registerByEmployee(
    Map<String, dynamic> employeeData,
  ) async {
    try {
      // Retrieve access token from secure storage
      final accessToken = await storage.read(key: 'access_token');
      if (accessToken == null) {
        throw Exception("Access token not found. Please log in again.");
      }

      // Make the API call with the token in the Authorization header
      final response = await postApi(
        "/accounts/register/employee/",
        data: employeeData,
      );
      return response.data;
    } on DioException catch (e) {
      if (e.response?.statusCode == 400) {
        throw Exception("Validation error: ${e.response?.data}");
      }
      throw Exception("Failed to register employee: ${e.message}");
    }
  }

  // Function to register an employer
  Future<Map<String, dynamic>> registerByEmployer(
    Map<String, dynamic> employerData,
  ) async {
    try {
      // Make the API call with the token in the Authorization header
      final response = await postApi(
        "/accounts/register/employer/",
        data: employerData,
      );
      return response.data;
    } on DioException catch (e) {
      if (e.response?.statusCode == 400) {
        throw Exception("Validation error: ${e.response?.data}");
      }
      throw Exception("Failed to register employer: ${e.message}");
    }
  }
}
