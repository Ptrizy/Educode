import 'package:quiz/data/model/course_response.dart';

abstract class CourseRepository {
  Future<CreateCourseResponse> createCourse(String title, String description);
  Future<CourseResponse> getCourseByClassId();
  Future<CourseResponse> getCourseById(String id);
}
