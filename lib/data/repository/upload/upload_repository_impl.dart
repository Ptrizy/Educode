import 'dart:io';
import 'package:dio/dio.dart';
import 'package:quiz/data/local/shared_preference/course_preference.dart';
import 'package:quiz/network/dio_client.dart';
import 'package:quiz/network/logger.dart';
import 'package:quiz/data/model/upload_response.dart';
import 'package:quiz/data/repository/upload/upload_repository.dart';
import 'package:quiz/network/api_config.dart';

class UploadRepositoryImpl implements UploadRepository {
  final ApiConfig _apiConfig = ApiConfig();
  final Dio _dio = DioClient().dio;

  @override
  Future<UploadResponse> uploadFile(File file) async {
    try {
      String fileName = file.path.split('/').last;
      FormData formData = FormData.fromMap(
        {
          "file": await MultipartFile.fromFile(
            file.path,
            filename: fileName,
          ),
        },
      );

      final response = await _dio.post(
        _apiConfig.uploadFile,
        data: formData,
        onSendProgress: (int sent, int total) {
          print('$sent / $total');
        },
      );
      print(response.data);

      if (response.statusCode == 201) {
        final url = response.data['data'];
        await CoursePreference.saveCourseUrl(url);

        return UploadResponse.fromJson(response.data);
      } else {
        throw Exception('Failed to upload file: ${response.statusCode}');
      }
    } catch (e) {
      AppLogger.error('Error in uploadFile', e);
      throw Exception('Failed to upload file: $e');
    }
  }
}
