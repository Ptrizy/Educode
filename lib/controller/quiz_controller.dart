import 'dart:io';
import 'dart:isolate';
import 'dart:ui';

import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:get/get.dart';
import 'package:open_file/open_file.dart';
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
  final Rx<QuizAttemptResponse?> quizResults = Rx<QuizAttemptResponse?>(null);

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
      final response = await _quizRepository.getQuizByID(quizId);
      currentQuiz.value = response;
      isLoading.value = false;
    } catch (e) {
      error.value = e.toString();
      isLoading.value = false;
      Get.snackbar('Error', 'Failed to load Quiz details: ${e.toString()}');
    }
    update();
  }

  Future<void> attemptQuiz(int quizID, List<QuizAnswer> answers) async {
    try {
      isLoading.value = true;
      error.value = null;

      final request = QuizAttemptRequest(quizID: quizID, answers: answers);

      final result = await _quizRepository.attemptQuiz(request);
      quizResults.value = result;
    } catch (e) {
      error.value = e.toString();
    } finally {
      isLoading.value = false;
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
        Directory? directory;
        if (Platform.isAndroid) {
          directory = await path_provider.getExternalStorageDirectory();
        } else {
          directory = await path_provider.getApplicationDocumentsDirectory();
        }

        if (directory != null) {
          final filePath = '${directory.path}/quiz_result.pdf';
          final taskId = await FlutterDownloader.enqueue(
            url: pdfUrl,
            savedDir: directory.path,
            fileName: "quiz_result.pdf",
            showNotification: true,
            openFileFromNotification: true,
          );

          if (taskId != null) {
            Get.snackbar('Success', 'Download started');

            await _monitorDownload(taskId, filePath);
          } else {
            Get.snackbar('Error', 'Failed to start download');
          }
        } else {
          Get.snackbar('Error', 'Could not access storage');
        }
      } catch (e) {
        Get.snackbar('Error', 'Download failed: ${e.toString()}');
      }
    } else if (status.isPermanentlyDenied) {
      Get.snackbar('Permission Permanently Denied',
          'Please open app settings and grant storage permission');
      await openAppSettings();
    } else {
      Get.snackbar(
          'Permission Denied', 'Please grant storage permission to download');
    }
  }

  Future<void> _monitorDownload(String taskId, String filePath) async {
    bool downloadComplete = false;
    while (!downloadComplete) {
      await Future.delayed(const Duration(seconds: 1));
      final tasks = await FlutterDownloader.loadTasks();
      final task = tasks?.firstWhere(
        (task) => task.taskId == taskId,
      );
      if (task != null) {
        if (task.status == DownloadTaskStatus.complete) {
          downloadComplete = true;
          Get.snackbar('Success', 'Download completed');
          await OpenFile.open(filePath);
        } else if (task.status == DownloadTaskStatus.failed) {
          Get.snackbar('Error', 'Download failed');
          break;
        }
      } else {
        Get.snackbar('Error', 'Download task not found');
        break;
      }
    }
  }
}
