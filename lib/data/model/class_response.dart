import 'package:quiz/data/model/auth_response.dart';

class ClassResponse {
  final Status status;
  final String message;
  final ClassData? data;

  ClassResponse({required this.status, required this.message, this.data});

  factory ClassResponse.fromJson(Map<String, dynamic> json) {
    return ClassResponse(
      status: Status.fromJson(json['status']),
      message: json['message'],
      data: json['data'] != null ? ClassData.fromJson(json['data']) : null,
    );
  }
}

class ClassData {
  final int id;
  final String name;
  final String teacherID;
  final String goal;
  final List<Course> courses;
  final List<Quiz> quizzes;
  final List<Video> videos;

  ClassData({
    required this.id,
    required this.name,
    required this.teacherID,
    required this.goal,
    required this.courses,
    required this.quizzes,
    required this.videos,
  });

  factory ClassData.fromJson(Map<String, dynamic> json) {
    return ClassData(
      id: json['id'],
      name: json['name'],
      teacherID: json['teacherID'],
      goal: json['goal'],
      courses:
          (json['courses'] as List).map((e) => Course.fromJson(e)).toList(),
      quizzes: (json['quizzes'] as List).map((e) => Quiz.fromJson(e)).toList(),
      videos: (json['videos'] as List).map((e) => Video.fromJson(e)).toList(),
    );
  }
}

class Course {
  final int id;
  final String course;
  final String title;
  final String description;

  Course({
    required this.id,
    required this.course,
    required this.title,
    required this.description,
  });

  factory Course.fromJson(Map<String, dynamic> json) {
    return Course(
      id: json['id'],
      course: json['course'],
      title: json['title'],
      description: json['description'],
    );
  }
}

class Quiz {
  final int id;
  final String name;
  final String description;

  Quiz({
    required this.id,
    required this.name,
    required this.description,
  });

  factory Quiz.fromJson(Map<String, dynamic> json) {
    return Quiz(
      id: json['id'],
      name: json['name'],
      description: json['description'],
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
