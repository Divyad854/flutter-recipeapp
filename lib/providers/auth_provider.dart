// auth_provider.dart - manages login state (mirrors iOS @AppStorage isLoggedIn)

import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../services/user_manager.dart';

class AuthProvider extends ChangeNotifier {
  bool _isLoggedIn = false;
  String _loggedInUsername = '';
  String _loggedInEmail = '';
  String _loggedInPassword = '';

  bool get isLoggedIn => _isLoggedIn;
  String get loggedInUsername => _loggedInUsername;
  String get loggedInEmail => _loggedInEmail;
  String get loggedInPassword => _loggedInPassword;

  Future<void> init() async {
    final prefs = await SharedPreferences.getInstance();
    _isLoggedIn = prefs.getBool('isLoggedIn') ?? false;
    _loggedInUsername = prefs.getString('loggedInUsername') ?? '';
    _loggedInEmail = prefs.getString('loggedInEmail') ?? '';
    _loggedInPassword = prefs.getString('loggedInPassword') ?? '';
    notifyListeners();
  }

  Future<String?> login(String email, String password) async {
    final user = await UserManager.shared.loginUser(
      email: email,
      password: password,
    );
    if (user != null) {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool('isLoggedIn', true);
      await prefs.setString('loggedInUsername', user.username);
      await prefs.setString('loggedInEmail', email);
      await prefs.setString('loggedInPassword', password);
      _isLoggedIn = true;
      _loggedInUsername = user.username;
      _loggedInEmail = email;
      _loggedInPassword = password;
      notifyListeners();
      return null; // success
    }
    return 'Invalid email or password';
  }

  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isLoggedIn', false);
    _isLoggedIn = false;
    _loggedInUsername = '';
    _loggedInEmail = '';
    _loggedInPassword = '';
    notifyListeners();
  }
}
