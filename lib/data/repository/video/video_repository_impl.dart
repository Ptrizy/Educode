import 'package:dio/dio.dart';
import 'package:quiz/data/local/shared_preference/class_preference.dart';
import 'package:quiz/network/dio_client.dart';
import 'package:quiz/network/logger.dart';
import 'package:quiz/data/model/video_response.dart';
import 'package:quiz/data/repository/video/video_repository.dart';
import 'package:quiz/network/api_config.dart';

class VideoRepositoryImpl implements VideoRepository {
  final ApiConfig _apiConfig = ApiConfig();
  final Dio _dio = DioClient().dio;

  @override
  Future<VideoResponse> getVideoByClassId() async {
    final classID = await ClassPreference.getClassID();
    try {
      final response = await _dio.get(_apiConfig.getVideoByClassID(classID!));
      print("ini response data: ${response.data}");

      return VideoResponse.fromJson(response.data);
    } catch (e) {
      AppLogger.error('Error in getVideoByClassId', e);
      rethrow;
    }
  }

  @override
  Future<VideoResponse> getVideoById(int id) async {
    try {
      final response = await _dio.get(_apiConfig.getVideoByID(id));
      return VideoResponse.fromJson(response.data);
    } catch (e) {
      AppLogger.error('Error in getVideoById', e);
      rethrow;
    }
  }
}
