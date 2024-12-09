import 'package:flutter/material.dart';
import 'package:jobr/data/services/accounts_service.dart';
import 'package:jobr/data/services/api_service.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final ApiService _apiService = ApiService();
  bool _isLoading = false;
  String? _errorMessage;

  // Login function
  Future<void> _login() async {
    final accountsService = AccountsService(_apiService);

    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      final response = await accountsService.login(
        _usernameController.text,
        _passwordController.text,
      );

      // Assuming response['success'] is true if login is successful
      if (response['success'] == true) {
        // Navigate to home screen or dashboard
        Navigator.of(context).pushReplacementNamed(
            '/home'); // Replace '/home' with actual route name
      } else {
        setState(() {
          _errorMessage = response['message'] ?? 'Login failed';
        });
      }
    } catch (e) {
      setState(() {
        _errorMessage = e.toString();
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  // Register employee function
  Future<void> _testRegisterEmployee() async {
    final accountsService = AccountsService(_apiService);

    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      final employeeData = {
        "date_of_birth": "1990-01-01",
        "gender": "male",
        "phone_number": "123456789",
        "city_name": "New York",
        "biography": "A hardworking individual.",
        "user": 1,
        "username": "user10",
        "email": "user10@gmail.com",
        "password": "password10",
        "latitude": "40.7128",
        "longitude": "-74.0060",
      };
      final response = await accountsService.registerByEmployee(employeeData);
      setState(() {
        _errorMessage =
            "Employee registered successfully: ${response.toString()}";
      });
    } catch (e) {
      setState(() {
        _errorMessage = e.toString();
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  // Register employer function
  Future<void> _testRegisterEmployer() async {
    final accountsService = AccountsService(_apiService);

    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      final employerData = {
        "vat_number": "123456789",
        "company_name": "TechCorp",
        "street_name": "Main Street",
        "house_number": "123",
        "city": "San Francisco",
        "postal_code": "94103",
        "coordinates": {"latitude": "37.7749", "longitude": "-122.4194"},
        "website": "https://www.techcorp.com",
        "biography": "A leading tech company.",
        "user": 2,
      };
      final response = await accountsService.registerByEmployer(employerData);
      setState(() {
        _errorMessage =
            "Employer registered successfully: ${response.toString()}";
      });
    } catch (e) {
      setState(() {
        _errorMessage = e.toString();
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Login"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _usernameController,
              decoration: const InputDecoration(labelText: "Username"),
            ),
            TextField(
              controller: _passwordController,
              decoration: const InputDecoration(labelText: "Password"),
              obscureText: true,
            ),
            const SizedBox(height: 16),
            if (_isLoading)
              const CircularProgressIndicator()
            else ...[
              ElevatedButton(
                onPressed: _login,
                child: const Text("Login"),
              ),
              ElevatedButton(
                onPressed: _testRegisterEmployee,
                child: const Text("Register Employee"),
              ),
              ElevatedButton(
                onPressed: _testRegisterEmployer,
                child: const Text("Register Employer"),
              ),
            ],
            if (_errorMessage != null)
              Padding(
                padding: const EdgeInsets.only(top: 16),
                child: Text(
                  _errorMessage!,
                  style: const TextStyle(color: Colors.red),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
