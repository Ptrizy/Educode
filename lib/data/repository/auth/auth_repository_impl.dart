import 'package:dio/dio.dart';
import 'package:quiz/data/local/shared_preference/auth_preference.dart';
import 'package:quiz/data/local/shared_preference/class_preference.dart';
import 'package:quiz/network/dio_client.dart';
import 'package:quiz/network/logger.dart';
import 'package:quiz/data/model/auth_response.dart';
import 'package:quiz/data/repository/auth/auth_repository.dart';
import 'package:quiz/network/api_config.dart';

class AuthRepositoryImpl implements AuthRepository {
  final ApiConfig _apiConfig = ApiConfig();
  final Dio _dio = DioClient().dio;

  @override
  Future<AuthResponse> signUp(
      String name, String password, String classRoom) async {
    try {
      final response = await _dio.post(
        _apiConfig.signUp,
        data: {
          'name': name,
          'password': password,
          'role': 'teacher',
          'class': classRoom,
        },
      );
      return AuthResponse.fromJson(response.data);
    } catch (e) {
      AppLogger.error('Error in signUp Teacher', e);
      rethrow;
    }
  }

  @override
  Future<AuthResponse> signUpStudent(String name, String password) async {
    try {
      final response = await _dio.post(
        _apiConfig.signUp,
        data: {
          'name': name,
          'role': 'student',
          'password': password,
        },
      );
      return AuthResponse.fromJson(response.data);
    } catch (e) {
      AppLogger.error('Error in signUp Student', e);
      rethrow;
    }
  }

  @override
  Future<AuthResponse> signIn(
      String name, String password, String classRoom) async {
    try {
      final response = await _dio.post(
        _apiConfig.signIn,
        data: {
          'name': name,
          'password': password,
          'class': classRoom,
        },
      );

      final authResponse = AuthResponse.fromJson(response.data);

      print(
          'ini adalah sign in token : \n${authResponse.data!.token.toString()}\n\n');

      if (authResponse.data?.token != null &&
          authResponse.data?.classId != null) {
        await AuthPreference.saveToken(authResponse.data!.token!);
        await ClassPreference.saveClassID(authResponse.data!.classId!);
      }

      print('ini response data ${response.data}');

      return AuthResponse.fromJson(response.data);
    } catch (e) {
      AppLogger.error('Error in signIn', e);
      rethrow;
    }
  }

  @override
  Future<bool> signOut() async {
    try {
      await AuthPreference.deleteToken();
      return true;
    } catch (e) {
      AppLogger.error('Error in signOut', e);
      return false;
    }
  }
}
