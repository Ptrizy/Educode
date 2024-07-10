import 'package:quiz/network/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ClassPreference {
  static const String _classIdKey = 'class_id_k';

  static Future<bool> saveClassID(int pClassID) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setInt(_classIdKey, pClassID);
      AppLogger.info('Sukses menyimpan Class ID');
      return true;
    } catch (e) {
      AppLogger.error('Error saat menyimpan Class ID', e);
      return false;
    }
  }

  static Future<int?> getClassID() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final classID = prefs.getInt(_classIdKey);
      if (classID != null) {
        AppLogger.info('Sukses mengembalika Class ID');
      } else {
        AppLogger.info('Tidak ada Class ID!');
      }
      return classID;
    } catch (e) {
      AppLogger.error('Error saat mengambil nilai Class ID', e);
      return null;
    }
  }

  static Future<bool> deleteClassID() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove(_classIdKey);
      AppLogger.info('Sukses menghapus Class ID');
      return true;
    } catch (e) {
      AppLogger.error('Error saat menghapus Class ID', e);
      return false;
    }
  }
}
