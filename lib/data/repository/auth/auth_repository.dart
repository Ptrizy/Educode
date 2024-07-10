import 'package:quiz/data/model/auth_response.dart';

abstract class AuthRepository {
  Future<AuthResponse> signUp(String name, String password, String classRoom);
  Future<AuthResponse> signIn(String name, String password, String classRoom);
  Future<AuthResponse> signUpStudent(String name, String password);
  Future<bool> signOut();
}
