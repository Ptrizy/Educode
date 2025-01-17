import 'package:flutter_dotenv/flutter_dotenv.dart';

class ApiConfig {
  final bool _isEmulator =
      false; // ganti ini ke false jika mau menggunakan perangkat fisik atau backend di server jarak jauh.
  final String _baseUrlEmulator = dotenv.env['BASE_URL']!;
  final String _baseUrlLocal = dotenv.env['BASE_URL']!;

  String get _baseUrl => _isEmulator ? _baseUrlEmulator : _baseUrlLocal;

  // auth endpoint
  String get signUp => "$_baseUrl/api/v1/auth/signup";
  String get signIn => "$_baseUrl/api/v1/auth/signin";
  // class endpoint
  String getOrPatchClassByID(String id) => "$_baseUrl/api/v1/classes/$id";
  // upload endpoint
  String get uploadFile => "$_baseUrl/api/v1/upload";
  // course endpoint
  String get createCourse => "$_baseUrl/api/v1/courses";
  String getCourseByClassID(int classId) => "$_baseUrl/api/v1/courses/$classId";
  String getCourseByID(String id) => "$_baseUrl/api/v1/courses/detail/$id";
  // quiz endpoint
  String getQuizByClassID(int classId) => "$_baseUrl/api/v1/quizzes/$classId";
  String getQuizByID(int id) => "$_baseUrl/api/v1/quizzes/detail/$id";
  String attemptQuiz() => "$_baseUrl/api/v1/quizzes/attempt";
  String getQuizResult(int quizId) => "$_baseUrl/api/v1/quizzes/result/$quizId";

  // video endpoint
  String getVideoByClassID(int classId) => "$_baseUrl/api/v1/videos/$classId";
  String getVideoByID(int id) => "$_baseUrl/api/v1/videos/detail/$id";
}
