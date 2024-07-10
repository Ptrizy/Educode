import 'package:get/get.dart';
import 'package:quiz/data/repository/class/class_repository.dart';

class ClassController extends GetxController {
  final ClassRepository _classRepository;

  ClassController(this._classRepository);

  final isLoading = false.obs;
  final error = Rx<String?>(null);

  Future<void> getClassByID(String id) async {
    isLoading.value = true;
    error.value = null;
    try {
      await _classRepository.getClassById(id);

      isLoading.value = false;
    } catch (e) {
      error.value = e.toString();
      Get.snackbar('Error', 'Signup failed: ${e.toString()}');
    }
  }
}
