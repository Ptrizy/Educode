import 'package:get/get.dart';
import 'package:quiz/data/model/course_response.dart';
import 'package:quiz/data/repository/course/course_repository.dart';

class CourseController extends GetxController {
  final CourseRepository _courseRepository;

  CourseController(this._courseRepository);

  final isLoading = false.obs;
  final error = Rx<String?>(null);
  final courses = Rx<List<CourseDetail>>([]);

  Future<void> createCourse(String title, String description) async {
    isLoading.value = true;
    error.value = null;
    try {
      await _courseRepository.createCourse(title, description);

      isLoading.value = false;
    } catch (e) {
      error.value = e.toString();
      isLoading.value = false;
      Get.snackbar('Error', 'Failed to load course: ${e.toString()}');
    }
  }

  Future<void> getCoursesByClassId() async {
    isLoading.value = true;
    error.value = null;
    try {
      final response = await _courseRepository.getCourseByClassId();
      courses.value = response.getCoursesAsList();
      isLoading.value = false;
    } catch (e) {
      error.value = e.toString();
      isLoading.value = false;
      Get.snackbar('Error', 'Failed to load course: ${e.toString()}');
    }
  }
}
