import 'package:get/get.dart';
import 'package:quiz/data/model/quiz_response.dart';
import 'package:quiz/data/repository/quiz/quiz_repository.dart';

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

  Future<void> getQuizResult(int quizId) async {
    isLoading.value = true;
    error.value = null;
    try {
      quizResult.value = await _quizRepository.getQuizResult(quizId);
      isLoading.value = false;
    } catch (e) {
      error.value = e.toString();
      isLoading.value = false;
      Get.snackbar('Error', 'Failed to load Quiz result: ${e.toString()}');
    }
  }
}
