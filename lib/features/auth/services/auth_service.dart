import 'package:dio/dio.dart';
import '../../../core/network/dio_client.dart';
import '../../../core/network/api_constants.dart';
import '../../../core/network/token_manager.dart';
import '../models/user_model.dart';

class AuthService {
  final DioClient _dioClient;
  final TokenManager _tokenManager;

  AuthService({DioClient? dioClient, TokenManager? tokenManager})
      : _dioClient = dioClient ?? DioClient(),
        _tokenManager = tokenManager ?? TokenManager();

  Future<UserModel> register({
    required String firstName,
    required String lastName,
    required String username,
    required String email,
    required String password,
  }) async {
    try {
      final response = await _dioClient.dio.post(
        ApiConstants.register,
        data: {
          'first_name': firstName,
          'last_name': lastName,
          'email': email,
          'password': password,
        },
      );
      
      // Auto login after successful registration or return a response
      // Depending on backend implementation, it might return tokens directly or you might need to login
      if (response.data != null && (response.data['token'] != null || response.data['accessToken'] != null)) {
         return _handleAuthSuccess(response.data);
      }
      return login(email: email, password: password);
    } catch (e) {
      throw _handleError(e);
    }
  }

  Future<UserModel> login({required String email, required String password}) async {
    try {
      final response = await _dioClient.dio.post(
        ApiConstants.login,
        data: {
          'email': email,
          'password': password,
        },
      );

      return _handleAuthSuccess(response.data);
    } catch (e) {
      throw _handleError(e);
    }
  }

  Future<UserModel> _handleAuthSuccess(Map<String, dynamic> data) async {
      final tokens = data['tokens'] ?? data; // Adjust based on your API structure
      final String? accessToken = tokens['accessToken'] ?? tokens['access_token'] ?? tokens['token'];
      final String? refreshToken = tokens['refreshToken'] ?? tokens['refresh_token'];
      
      if (accessToken != null) {
          await _tokenManager.saveTokens(
            accessToken: accessToken, 
            refreshToken: refreshToken ?? '',
          );
      }
      
      final userData = data['user'] ?? data;
      return UserModel.fromJson(userData);
  }

  Future<UserModel> getProfile() async {
    try {
      final response = await _dioClient.dio.get(ApiConstants.profile);
      return UserModel.fromJson(response.data['user'] ?? response.data);
    } on DioException catch (e) {
      if (e.response?.statusCode == 422) {
        final messages = e.response?.data['detail'] as List;
        final errorMsg = messages.map((m) => '${m['loc'].last}: ${m['msg']}').join(', ');
        throw Exception(errorMsg);
      }
      throw Exception(e.response?.data['detail'] ?? e.message);
    } catch (e) {
      throw _handleError(e);
    }
  }

  Future<void> logout() async {
    try {
      await _dioClient.dio.post(ApiConstants.logout);
    } catch (e) {
      // Ignore if logout request fails, still want to clear local tokens
    } finally {
      await _tokenManager.clearTokens();
    }
  }
  
  Future<bool> checkAuth() async {
     final token = await _tokenManager.getAccessToken();
     return token != null && token.isNotEmpty;
  }

  String _handleError(dynamic e) {
    if (e is DioException) {
      if (e.response != null && e.response?.data != null) {
        final data = e.response?.data;
        if (e.response?.statusCode == 422 && data['detail'] is List) {
          final messages = data['detail'] as List;
          return messages.map((m) => '${m['loc'].last}: ${m['msg']}').join(', ');
        }
        if (data is Map && data.containsKey('detail') && data['detail'] is String) {
          return data['detail'].toString();
        }
        if (data is Map && data.containsKey('message')) {
          return data['message'].toString();
        }
        if (data is Map && data.containsKey('error')) {
          return data['error'].toString();
        }
      }
      return 'Network error: ${e.message}';
    }
    return e.toString();
  }
}
