import 'package:quiz/data/model/auth_response.dart';
import 'package:quiz/data/model/class_response.dart';

abstract class ClassRepository {
  Future<ClassResponse> getClassById(String id);
  Future<AuthResponse> updateClass(String id, Map<String, dynamic> data);
}
