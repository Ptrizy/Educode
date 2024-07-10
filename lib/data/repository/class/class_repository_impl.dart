import 'package:dio/dio.dart';
import 'package:quiz/network/dio_client.dart';
import 'package:quiz/network/logger.dart';
import 'package:quiz/data/model/auth_response.dart';
import 'package:quiz/data/model/class_response.dart';
import 'package:quiz/data/repository/class/class_repository.dart';
import 'package:quiz/network/api_config.dart';

class ClassRepositoryImpl implements ClassRepository {
  final ApiConfig _apiConfig = ApiConfig();
  final Dio _dio = DioClient().dio;

  @override
  Future<ClassResponse> getClassById(String id) async {
    try {
      final response = await _dio.get(_apiConfig.getOrPatchClassByID(id));
      return ClassResponse.fromJson(response.data);
    } catch (e) {
      AppLogger.error('Error in getClassById', e);
      rethrow;
    }
  }

  @override
  Future<AuthResponse> updateClass(String id, Map<String, dynamic> data) async {
    try {
      final response =
          await _dio.patch(_apiConfig.getOrPatchClassByID(id), data: data);
      return AuthResponse.fromJson(response.data);
    } catch (e) {
      AppLogger.error('Error in updateClass', e);
      rethrow;
    }
  }
}
