import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:quiz/data/model/quiz_response.dart';
import 'package:quiz/data/repository/quiz/quiz_repository.dart';
import 'package:path_provider/path_provider.dart' as path_provider;

class QuizController extends GetxController {
  final QuizRepository _quizRepository;

  QuizController(this._quizRepository);

  final isLoading = false.obs;
  final error = Rx<String?>(null);
  final quizzes = <QuizInfo>[].obs;
  final currentQuiz = Rx<QuizDetail?>(null);
  final quizResult = Rx<QuizResult?>(null);

  Future<void> getQuizByClassID() async {
    isLoading.value = true;
    error.value = null;
    try {
      final response = await _quizRepository.getQuizByClassID();
      quizzes.value = response.data;
      isLoading.value = false;
    } catch (e) {
      error.value = e.toString();
      isLoading.value = false;
      Get.snackbar('Error', 'Failed to load Quizzes: ${e.toString()}');
    }
  }

  Future<void> getQuizById(int quizId) async {
    isLoading.value = true;
    error.value = null;
    try {
      final response = await _quizRepository.getQuizByID();
      currentQuiz.value = response;
      isLoading.value = false;
    } catch (e) {
      error.value = e.toString();
      isLoading.value = false;
      Get.snackbar('Error', 'Failed to load Quiz details: ${e.toString()}');
    }
    update();
  }

  Future<void> attemptQuiz(QuizAttemptRequest request) async {
    isLoading.value = true;
    error.value = null;
    try {
      await _quizRepository.attemptQuiz(request);
      isLoading.value = false;
      Get.snackbar('Success', 'Quiz submitted successfully');
    } catch (e) {
      error.value = e.toString();
      isLoading.value = false;
      Get.snackbar('Error', 'Failed to submit Quiz: ${e.toString()}');
    }
  }

  Future<void> getQuizResult() async {
    isLoading.value = true;
    error.value = null;
    try {
      quizResult.value = await _quizRepository.getQuizResult();
      isLoading.value = false;
    } catch (e) {
      error.value = e.toString();
      isLoading.value = false;
      Get.snackbar('Error', 'Failed to load Quiz result: ${e.toString()}');
    }
  }

  Future<void> downloadPDF() async {
    final pdfUrl = quizResult.value?.data;
    if (pdfUrl == null || pdfUrl.isEmpty) {
      Get.snackbar('Error', 'No PDF available to download');
      return;
    }

    final status = await Permission.storage.request();

    if (status.isGranted) {
      try {
        final externalDir = await path_provider.getExternalStorageDirectory();

        if (externalDir != null) {
          final taskId = await FlutterDownloader.enqueue(
            url: pdfUrl,
            savedDir: externalDir.path,
            fileName: "quiz_result.pdf",
            showNotification: true,
            openFileFromNotification: true,
          );

          if (taskId != null) {
            Get.snackbar('Success', 'Download started');
          } else {
            Get.snackbar('Error', 'Failed to start download');
          }
        } else {
          Get.snackbar('Error', 'Could not access external storage');
        }
      } catch (e) {
        Get.snackbar('Error', 'Download failed: ${e.toString()}');
      }
    } else {
      Get.snackbar(
          'Permission Denied', 'Please grant storage permission to download');
    }
  }
}
