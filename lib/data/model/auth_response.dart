class AuthResponse {
  final Status status;
  final String message;
  final AuthData? data;

  AuthResponse({required this.status, required this.message, this.data});

  factory AuthResponse.fromJson(Map<String, dynamic> json) {
    return AuthResponse(
      status: Status.fromJson(json['status']),
      message: json['message'],
      data: json['data'] != null ? AuthData.fromJson(json['data']) : null,
    );
  }
}

class Status {
  final int code;

  Status({required this.code});

  factory Status.fromJson(Map<String, dynamic> json) {
    return Status(code: json['code']);
  }
}

class AuthData {
  final int? classId;
  final String? token;

  AuthData({this.classId, this.token});

  factory AuthData.fromJson(Map<String, dynamic> json) {
    return AuthData(
      classId: json['class_id'],
      token: json['token'],
    );
  }
}
