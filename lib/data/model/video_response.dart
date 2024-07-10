import 'package:quiz/data/model/auth_response.dart';

class VideoResponse {
  final Status status;
  final String message;
  final List<Video> data;

  VideoResponse({
    required this.status,
    required this.message,
    required this.data,
  });

  factory VideoResponse.fromJson(Map<String, dynamic> json) {
    return VideoResponse(
      status: Status.fromJson(json['status']),
      message: json['message'],
      data: (json['data'] as List).map((item) => Video.fromJson(item)).toList(),
    );
  }
}

class Video {
  final int id;
  final String video;
  final String title;
  final String description;

  Video({
    required this.id,
    required this.video,
    required this.title,
    required this.description,
  });

  factory Video.fromJson(Map<String, dynamic> json) {
    return Video(
      id: json['id'],
      video: json['video'],
      title: json['title'],
      description: json['description'],
    );
  }
}
