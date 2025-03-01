import 'package:dio/dio.dart';
import 'package:jobr/core/routing/router.dart';
import 'package:jobr/data/models/user.dart';
import 'package:jobr/data/services/api_service.dart';
import 'package:jobr/features/authentication/screens/splash_screen.dart';

class AccountsService extends ApiService {
  Future<void> logout() async {
    await clearTokens();

    router.pushReplacement(SplashScreen.route);
  }

  Future<UserType> checkAuthentication() async {
    Map<String, String?> tokens = await ApiService.getTokens();

    String? accessToken = tokens['access_token'];
    String? refreshToken = tokens['refresh_token'];

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

      setTokens(response.data['access'], response.data['refresh']);

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

      setTokens(response.data['access'], response.data['refresh']);

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

  Future<List<User>> getAiSuggestions() async {
    try {
      final response = await getApi(
        "/accounts/ai/suggestions",
      );

      List? data = response.data as List?;

      if (data?.isEmpty ?? true) {
        return [];
      }

      return data!.map((e) => User.fromJson(e)).toList();
    } on DioException catch (e) {
      throw Exception("Failed to get ai suggestions: ${e.message}");
    }
  }
}
