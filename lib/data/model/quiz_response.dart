// Model untuk getQuizByClassID
import 'package:quiz/data/model/auth_response.dart';

class QuizResponse {
  final Status status;
  final String message;
  final List<QuizInfo> data;

  QuizResponse({
    required this.status,
    required this.message,
    required this.data,
  });

  factory QuizResponse.fromJson(Map<String, dynamic> json) => QuizResponse(
        status: Status.fromJson(json['status'] as Map<String, dynamic>),
        message: json['message'] as String,
        data: (json['data'] as List<dynamic>)
            .map((x) => QuizInfo.fromJson(x as Map<String, dynamic>))
            .toList(),
      );
}

class QuizInfo {
  final int id;
  final String name;
  final String description;

  QuizInfo({
    required this.id,
    required this.name,
    required this.description,
  });

  factory QuizInfo.fromJson(Map<String, dynamic> json) => QuizInfo(
        id: json['id'],
        name: json['name'],
        description: json['description'],
      );
}

// Model untuk getQuizByID
class QuizDetail {
  final Status status;
  final String message;
  final QuizData data;

  QuizDetail({
    required this.status,
    required this.message,
    required this.data,
  });

  factory QuizDetail.fromJson(Map<String, dynamic> json) => QuizDetail(
        status: Status.fromJson(json['status']),
        message: json['message'],
        data: QuizData.fromJson(json['data']),
      );
}

class QuizData {
  final int id;
  final String name;
  final String description;
  final List<Question> questions;

  QuizData({
    required this.id,
    required this.name,
    required this.description,
    required this.questions,
  });

  factory QuizData.fromJson(Map<String, dynamic> json) {
    try {
      return QuizData(
        id: json['id'],
        name: json['name'],
        description: json['description'],
        questions: (json['questions'] as List)
            .map((q) => Question.fromJson(q))
            .toList(),
      );
    } catch (e) {
      print('Error parsing QuizData: $e');
      rethrow;
    }
  }
}

class Question {
  final int id;
  final String question;
  final String optionA;
  final String optionB;
  final String optionC;
  final String optionD;
  final String? optionE;

  Question({
    required this.id,
    required this.question,
    required this.optionA,
    required this.optionB,
    required this.optionC,
    required this.optionD,
    this.optionE,
  });

  factory Question.fromJson(Map<String, dynamic> json) => Question(
        id: json['id'],
        question: json['question'],
        optionA: json['optionA'],
        optionB: json['optionB'],
        optionC: json['optionC'],
        optionD: json['optionD'],
        optionE: json['optionE'],
      );
}

// Model untuk attemptQuiz
class QuizAttemptResponse {
  final Status status;
  final String message;
  final AttemptResult data;

  QuizAttemptResponse({
    required this.status,
    required this.message,
    required this.data,
  });

  factory QuizAttemptResponse.fromJson(Map<String, dynamic> json) =>
      QuizAttemptResponse(
        status: Status.fromJson(json['status']),
        message: json['message'],
        data: AttemptResult.fromJson(json['data']),
      );
}

class AttemptResult {
  final int result;
  final int rightAnswer;
  final int wrongAnswer;

  AttemptResult({
    required this.result,
    required this.rightAnswer,
    required this.wrongAnswer,
  });

  factory AttemptResult.fromJson(Map<String, dynamic> json) => AttemptResult(
        result: json['result'],
        rightAnswer: json['rightAnswer'],
        wrongAnswer: json['wrongAnswer'],
      );
}

//Model untuk request quiz attempt
class QuizAttemptRequest {
  final int quizID;
  final List<QuizAnswer> answers;

  QuizAttemptRequest({required this.quizID, required this.answers});

  Map<String, dynamic> toJson() {
    return {
      'quizID': quizID,
      'answers': answers.map((answer) => answer.toJson()).toList(),
    };
  }
}

class QuizAnswer {
  final int quizQuestionID;
  final String answer;

  QuizAnswer({required this.quizQuestionID, required this.answer});

  Map<String, dynamic> toJson() {
    return {
      'quizQuestionID': quizQuestionID,
      'answer': answer,
    };
  }
}

class QuizResult {
  Status? status;
  String? message;
  String? data;

  QuizResult({
    this.status,
    this.message,
    this.data,
  });

  factory QuizResult.fromJson(Map<String, dynamic> json) => QuizResult(
        status: json["status"] == null ? null : Status.fromJson(json["status"]),
        message: json["message"],
        data: json["data"],
      );
}
