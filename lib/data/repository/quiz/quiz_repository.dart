import 'package:quiz/data/model/quiz_response.dart';

abstract class QuizRepository {
  Future<QuizResponse> getQuizByClassID();
  Future<QuizDetail> getQuizByID(int id);
  Future<QuizAttemptResponse> attemptQuiz(QuizAttemptRequest request);
  Future<QuizResult?> getQuizResult(int quizId);
}
