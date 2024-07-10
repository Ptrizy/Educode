import 'package:quiz/network/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthPreference {
  static const String _tokenKey = 'auth_token';
  // menyimpan token
  static Future<bool> saveToken(String token) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(_tokenKey, token);
      AppLogger.info('Sukses menyimpan token');
      return true;
    } catch (e) {
      AppLogger.error('Error saat menyimpan token', e);
      return false;
    }
  }

  static Future<String?> getToken() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString(_tokenKey);
      if (token != null) {
        AppLogger.info('Sukses mengembalikan token');
      } else {
        AppLogger.info('Tidak ada token!');
      }
      return token;
    } catch (e) {
      AppLogger.error('Error saat mengembalikan token', e);
      return null;
    }
  }

  static Future<bool> deleteToken() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove(_tokenKey);
      AppLogger.info('Sukses menghapus token');
      return true;
    } catch (e) {
      AppLogger.error('Error saat menghapus token', e);
      return false;
    }
  }
}
