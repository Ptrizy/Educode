import 'package:dio/dio.dart';
import 'package:quiz/data/local/shared_preference/class_preference.dart';
import 'package:quiz/data/model/quiz_response.dart';
import 'package:quiz/data/repository/quiz/quiz_repository.dart';
import 'package:quiz/network/api_config.dart';
import 'package:quiz/network/dio_client.dart';
import 'package:quiz/network/logger.dart';

class QuizRepositoryImpl implements QuizRepository {
  final ApiConfig _apiConfig = ApiConfig();
  final Dio _dio = DioClient().dio;

  @override
  Future<QuizAttemptResponse> attemptQuiz(QuizAttemptRequest request) async {
    try {
      final response = await _dio.post(
        _apiConfig.attemptQuiz(),
        data: {request},
      );
      return QuizAttemptResponse.fromJson(response.data);
    } catch (e) {
      AppLogger.error('Error saat attemptQuiz', e);
      rethrow;
    }
  }

  @override
  Future<QuizResponse> getQuizByClassID() async {
    try {
      final classID = await ClassPreference.getClassID();
      final response = await _dio.get(
        _apiConfig.getQuizByClassID(classID!),
      );
      // Pastikan bahwa response.data adalah Map<String, dynamic>
      return QuizResponse.fromJson(response.data as Map<String, dynamic>);
    } catch (e) {
      AppLogger.error("Error saat getQuizByClassID", e);
      rethrow;
    }
  }

  @override
  Future<QuizDetail> getQuizByID() async {
    try {
      final classId = await ClassPreference.getClassID();
      final response = await _dio.get(
        _apiConfig.getQuizByID(classId!),
      );
      return QuizDetail.fromJson(response.data);
    } catch (e) {
      AppLogger.error('Error saat getQuizByID', e);
      rethrow;
    }
  }

  @override
  Future<QuizResult?> getQuizResult() async {
    try {
      final classId = await ClassPreference.getClassID();
      final response = await _dio.get(
        _apiConfig.getQuizResult(classId!),
      );
      return QuizResult.fromJson(response.data);
    } catch (e) {
      AppLogger.error('Error saat getQuizResult', e);
      return null;
    }
  }
}
