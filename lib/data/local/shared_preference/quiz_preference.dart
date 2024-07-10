import 'package:quiz/network/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

class QuizPreference {
  static const String _quizID = 'quiz_id';

  static Future<bool> saveQuizID(int id) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setInt(_quizID, id);
      AppLogger.info('Sukses menyimpan Quiz ID');
      return true;
    } catch (e) {
      AppLogger.error('Error saat menyimpan Quiz ID', e);
      return false;
    }
  }

  static Future<int?> getQuizId() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final qId = prefs.getInt(_quizID);
      if (qId != null) {
        AppLogger.info('Sukses mengembalikan quiz id');
      } else {
        AppLogger.info('Tidak ada quiz id!');
      }
      return qId;
    } catch (e) {
      AppLogger.error('Error saat mengambil quiz id', e);
      return null;
    }
  }

  static Future<bool> deleteQuizID() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove(_quizID);
      AppLogger.info('Sukses menghapus quiz id');
      return true;
    } catch (e) {
      AppLogger.error('Error saat menghapus quiz id', e);
      return false;
    }
  }
}
