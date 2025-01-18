import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../models/user.dart';
import '../services/accounts_service.dart';
import '../services/api_service.dart';

// API Service Provider
final apiServiceProvider = Provider<ApiService>((ref) {
  return ApiService();
});

// Accounts Service Provider
final accountsServiceProvider = Provider<AccountsService>((ref) {
  final apiService = ref.read(apiServiceProvider);
  return AccountsService(apiService);
});

// Authentication State
class AuthState {
  final User? user;
  final bool isLoading;
  final String? error;

  AuthState({
    this.user,
    this.isLoading = false,
    this.error,
  });

  AuthState copyWith({
    User? user,
    bool? isLoading,
    String? error,
  }) {
    return AuthState(
      user: user ?? this.user,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
    );
  }
}

// Authentication Notifier
class AuthNotifier extends StateNotifier<AuthState> {
  final AccountsService accountsService;
  final FlutterSecureStorage storage;

  AuthNotifier(this.accountsService, this.storage) : super(AuthState());

  Future<void> login(String username, String password) async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      // Perform login
      final loginResponse = await accountsService.login(username, password);

      // TODO: Fetch user details after successful login
      // You might want to add a method in AccountsService to fetch user details
      final user = User.fromJson(loginResponse);

      state = state.copyWith(
        isLoading: false,
        user: user,
        error: null,
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: e.toString(),
      );
    }
  }

  Future<void> logout() async {
    await storage.deleteAll();
    state = AuthState();
  }

  Future<void> registerEmployee(Map<String, dynamic> employeeData) async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      final registerResponse =
          await accountsService.registerByEmployee(employeeData);
      // Handle registration success
      state = state.copyWith(isLoading: false);
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: e.toString(),
      );
    }
  }

  Future<void> registerEmployer(Map<String, dynamic> employerData) async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      final registerResponse =
          await accountsService.registerByEmployer(employerData);
      // Handle registration success
      state = state.copyWith(isLoading: false);
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: e.toString(),
      );
    }
  }
}

// Auth Provider
final authProvider = StateNotifierProvider<AuthNotifier, AuthState>((ref) {
  final accountsService = ref.read(accountsServiceProvider);
  const storage = FlutterSecureStorage();
  return AuthNotifier(accountsService, storage);
});

// Token Providers
final accessTokenProvider = FutureProvider<String?>((ref) async {
  const storage = FlutterSecureStorage();
  return await storage.read(key: 'access_token');
});

final refreshTokenProvider = FutureProvider<String?>((ref) async {
  const storage = FlutterSecureStorage();
  return await storage.read(key: 'refresh_token');
});
