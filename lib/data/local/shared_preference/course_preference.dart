import 'package:quiz/network/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CoursePreference {
  static const String _courseUrl = 'course_url';

  static Future<bool> saveCourseUrl(String url) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(_courseUrl, url);
      AppLogger.info('Sukses menyimpan Class ID');
      return true;
    } catch (e) {
      AppLogger.error('Error saat menyimpan Class ID', e);
      return false;
    }
  }

  static Future<String?> getCourseUrl() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final url = prefs.getString(_courseUrl);
      if (url != null) {
        AppLogger.info('Sukses mengembalikan Url Course');
      } else {
        AppLogger.info('Tidak ada Url untuk Course!');
      }
      return url;
    } catch (e) {
      AppLogger.error('Error saat mengambil nilai Url Course', e);
      return null;
    }
  }

  static Future<bool> deleteCourseUrl() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove(_courseUrl);
      AppLogger.info('Sukses menghapus Url dari Course');
      return true;
    } catch (e) {
      AppLogger.error('Error saat menghapus Url Course', e);
      return false;
    }
  }
}
