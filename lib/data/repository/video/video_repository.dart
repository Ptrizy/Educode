import 'package:quiz/data/model/video_response.dart';

abstract class VideoRepository {
  Future<VideoResponse> getVideoByClassId();
  Future<VideoResponse> getVideoById(int id);
}
