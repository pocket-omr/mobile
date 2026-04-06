import 'package:flutter/material.dart';
import '../models/user_model.dart';
import '../services/auth_service.dart';

enum AuthStatus {
  initial,
  loading,
  authenticated,
  unauthenticated,
  error,
}

class AuthProvider extends ChangeNotifier {
  final AuthService _authService;

  UserModel? _user;
  AuthStatus _status = AuthStatus.initial;
  String? _errorMessage;

  AuthProvider({AuthService? authService}) 
      : _authService = authService ?? AuthService() {
    _checkAuthStatus();
  }

  UserModel? get user => _user;
  AuthStatus get status => _status;
  String? get errorMessage => _errorMessage;

  void _setStatus(AuthStatus status, {String? errorMessage}) {
    _status = status;
    _errorMessage = errorMessage;
    notifyListeners();
  }

  Future<void> _checkAuthStatus() async {
    _setStatus(AuthStatus.loading);
    try {
      final isAuth = await _authService.checkAuth();
      if (isAuth) {
        _user = await _authService.getProfile();
        _setStatus(AuthStatus.authenticated);
      } else {
        _setStatus(AuthStatus.unauthenticated);
      }
    } catch (e) {
      _setStatus(AuthStatus.unauthenticated); // Could not fetch profile
    }
  }

  Future<bool> login(String email, String password) async {
    _setStatus(AuthStatus.loading);
    try {
      _user = await _authService.login(email: email, password: password);
      _setStatus(AuthStatus.authenticated);
      return true;
    } catch (e) {
      _setStatus(AuthStatus.error, errorMessage: e.toString());
      return false;
    }
  }

  Future<bool> register({
    required String firstName,
    required String lastName,
    required String username,
    required String email,
    required String password,
  }) async {
    _setStatus(AuthStatus.loading);
    try {
      _user = await _authService.register(
        firstName: firstName,
        lastName: lastName,
        username: username,
        email: email,
        password: password,
      );
      _setStatus(AuthStatus.authenticated);
      return true;
    } catch (e) {
      _setStatus(AuthStatus.error, errorMessage: e.toString());
      return false;
    }
  }

  Future<void> logout() async {
    _setStatus(AuthStatus.loading);
    await _authService.logout();
    _user = null;
    _setStatus(AuthStatus.unauthenticated);
  }
}
