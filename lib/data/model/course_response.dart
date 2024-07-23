import 'package:quiz/data/model/auth_response.dart';

class CourseResponse {
  final Status status;
  final String message;
  final dynamic data;

  CourseResponse(
      {required this.status, required this.message, required this.data});

  factory CourseResponse.fromJson(Map<String, dynamic> json) {
    return CourseResponse(
      status: Status.fromJson(json['status']),
      message: json['message'],
      data: json['data'],
    );
  }

  List<CourseDetail> getCoursesAsList() {
    if (data is List) {
      return (data as List).map((item) => CourseDetail.fromJson(item)).toList();
    } else if (data is Map<String, dynamic>) {
      return [CourseDetail.fromJson(data)];
    }
    return [];
  }
}

class CourseDetail {
  final int? id;
  final int? classID;
  final String course;
  final String title;
  final String description;

  CourseDetail({
    this.id,
    this.classID,
    required this.course,
    required this.title,
    required this.description,
  });

  factory CourseDetail.fromJson(Map<String, dynamic> json) {
    return CourseDetail(
      id: json['id'] != null ? json['id'] as int : null,
      classID: json['classID'] != null ? json['classID'] as int : null,
      course: json['course'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
    );
  }
}

class CreateCourseResponse {
  final Status status;
  final String message;

  CreateCourseResponse({required this.status, required this.message});

  factory CreateCourseResponse.fromJson(Map<String, dynamic> json) {
    return CreateCourseResponse(
      status: Status.fromJson(json['status']),
      message: json['message'],
    );
  }
}
