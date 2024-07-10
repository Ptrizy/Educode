import 'package:dio/dio.dart';
import 'package:quiz/data/local/shared_preference/class_preference.dart';
import 'package:quiz/data/local/shared_preference/course_preference.dart';
import 'package:quiz/network/dio_client.dart';
import 'package:quiz/network/logger.dart';
import 'package:quiz/data/model/course_response.dart';
import 'package:quiz/data/repository/course/course_repository.dart';
import 'package:quiz/network/api_config.dart';

class CourseRepositoryImpl implements CourseRepository {
  final ApiConfig _apiConfig = ApiConfig();
  final Dio _dio = DioClient().dio;

  @override
  Future<CreateCourseResponse> createCourse(
      String title, String description) async {
    try {
      final int? classId = await ClassPreference.getClassID();
      final String? courseUrl = await CoursePreference.getCourseUrl();
      final response = await _dio.post(
        _apiConfig.createCourse,
        data: {
          'classID': classId,
          'course': courseUrl,
          'title': title,
          'description': description,
        },
      );
      return CreateCourseResponse.fromJson(response.data);
    } catch (e) {
      AppLogger.error('Error in createCourse', e);
      rethrow;
    }
  }

  @override
  Future<CourseResponse> getCourseByClassId() async {
    final classID = await ClassPreference.getClassID();
    try {
      final response = await _dio.get(_apiConfig.getCourseByClassID(classID!));
      print("ini response data: ${response.data}");

      return CourseResponse.fromJson(response.data);
    } catch (e) {
      AppLogger.error('Error in getCourseByClassId', e);
      rethrow;
    }
  }

  @override
  Future<CourseResponse> getCourseById(String id) async {
    try {
      final response = await _dio.get(_apiConfig.getCourseByID(id));
      return CourseResponse.fromJson(response.data);
    } catch (e) {
      AppLogger.error('Error in getCourseById', e);
      rethrow;
    }
  }
}
