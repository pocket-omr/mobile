class ApiConstants {
  // localhost for Chrome/web & iOS simulator
  // Use 10.0.2.2 when running on Android emulator
  static const String baseUrl = 'http://localhost:8000/api/v1';

  // Auth endpoints
  static const String healthCount = '/health';
  static const String register = '/auth/register';
  static const String login = '/auth/login';
  static const String profile = '/auth/me';
  static const String refresh = '/auth/refresh';
  static const String logout = '/auth/logout';
}
