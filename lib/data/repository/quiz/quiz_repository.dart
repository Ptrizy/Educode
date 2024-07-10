import 'package:quiz/data/model/quiz_response.dart';

abstract class QuizRepository {
  Future<QuizResponse> getQuizByClassID();
  Future<QuizDetail> getQuizByID();
  Future<QuizAttemptResponse> attemptQuiz(QuizAttemptRequest request);
  Future<QuizResult?> getQuizResult();
}
