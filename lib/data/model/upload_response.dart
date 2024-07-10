import 'package:quiz/data/model/auth_response.dart';

class UploadResponse {
  final Status status;
  final String message;
  final String? data;

  UploadResponse({required this.status, required this.message, this.data});

  factory UploadResponse.fromJson(Map<String, dynamic> json) {
    return UploadResponse(
      status: Status.fromJson(json['status']),
      message: json['message'],
      data: json['data'],
    );
  }
}
