import 'dart:convert';

import '../models/user_model.dart';
import 'auth_datasource.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthLocalDataSource implements AuthDatasource {
  // Mock user data
  final UserModel _mockUser = const UserModel(
    email: 'test@example.com',
    password: 'password123',
  );

  @override
  Future<UserModel?> login({
    required String email,
    required String password,
  }) async {
    await Future.delayed(const Duration(milliseconds: 500));
    if (email == _mockUser.email && password == _mockUser.password) {
      return _mockUser;
    }
    return null;
  }

  @override
  Future<void> saveLoginInfo(bool isLoggedIn, UserModel? user) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isLoggedIn', isLoggedIn);
    if (user != null) {
      await prefs.setString('user', jsonEncode(user.toJson()));
    }
  }

  @override
  Future<bool> checkLoginStatus() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool('isLoggedIn') ?? false;
  }

  Future<UserModel?> getUser() async {
    final prefs = await SharedPreferences.getInstance();
    final userJson = prefs.getString('user');
    if (userJson != null) {
      return UserModel.fromJson(jsonDecode(userJson));
    }
    return null;
  }
}
