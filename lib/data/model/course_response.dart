import 'package:quiz/data/model/auth_response.dart';

class CourseResponse {
  final Status status;
  final String message;
  final List<CourseDetail> data;

  CourseResponse(
      {required this.status, required this.message, required this.data});

  factory CourseResponse.fromJson(Map<String, dynamic> json) {
    return CourseResponse(
      status: Status.fromJson(json['status']),
      message: json['message'],
      data: (json['data'] as List)
          .map((item) => CourseDetail.fromJson(item))
          .toList(),
    );
  }
}

class CourseDetail {
  final int id;
  final int? classID;
  final String course;
  final String title;
  final String description;

  CourseDetail({
    required this.id,
    this.classID,
    required this.course,
    required this.title,
    required this.description,
  });

  factory CourseDetail.fromJson(Map<String, dynamic> json) {
    return CourseDetail(
      id: json['id'],
      classID: json['classID'],
      course: json['course'],
      title: json['title'],
      description: json['description'],
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
