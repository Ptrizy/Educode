import 'package:get/get.dart';
import 'package:quiz/data/repository/auth/auth_repository.dart';

class AuthController extends GetxController {
  final AuthRepository _authRepository;

  AuthController(this._authRepository);

  final isLoading = false.obs;
  final error = Rx<String?>(null);

  Future<void> signUp(String name, String password, String classRoom) async {
    isLoading.value = true;
    error.value = null;
    try {
      _authRepository.signUp(name, password, classRoom);

      Get.snackbar('Success', 'Signup sukses');
      isLoading.value = false;
    } catch (e) {
      error.value = e.toString();
      isLoading.value = false;
      Get.snackbar('Error', 'Signup failed: ${e.toString()}');
    }
  }

  Future<void> signUpStudent(String name, String classRoom) async {
    isLoading.value = true;
    error.value = null;
    try {
      _authRepository.signUpStudent(name, classRoom);

      Get.snackbar('Success', 'Signup sukses');
      isLoading.value = false;
    } catch (e) {
      error.value = e.toString();
      isLoading.value = false;
      Get.snackbar('Error', 'Signup failed: ${e.toString()}');
    }
  }

  Future<void> signIn(String name, String password, String classRoom) async {
    isLoading.value = true;
    error.value = null;
    try {
      _authRepository.signIn(name, password, classRoom);

      Get.snackbar('Success', 'Login sukses');
      isLoading.value = false;
    } catch (e) {
      error.value = e.toString();
      isLoading.value = false;
      Get.snackbar('Error', 'Login failed: ${e.toString()}');
    }
  }

  Future<void> signInStudent(
      String name, String classRoom, String password) async {
    isLoading.value = true;
    error.value = null;
    try {
      _authRepository.signIn(name, classRoom, password);

      Get.snackbar('Success', 'Login sukses');
      isLoading.value = false;
    } catch (e) {
      error.value = e.toString();
      isLoading.value = false;
      Get.snackbar('Error', 'Login failed: ${e.toString()}');
    }
  }

  Future<void> signOut() async {
    isLoading.value = true;
    error.value = null;
    try {
      final success = await _authRepository.signOut();
      if (success) {
        Get.offAllNamed('/login');
        Get.snackbar('Success', 'Anda telah keluar, silahkan masuk kembali');
      } else {
        throw Exception('Signout failed');
      }
    } catch (e) {
      error.value = e.toString();

      isLoading.value = false;
    }
  }
}
