import 'package:shared_preferences/shared_preferences.dart';

class LocalStorageService {
  static LocalStorageService _instance;
  static SharedPreferences _preferences;

  static const String usrLoggedKey = 'usr_logged'; //usuario logado
  static const String loginDateKey = 'date_login'; //data de login

  static Future<LocalStorageService> getInstance() async {
    if (_instance == null) {
      _instance = LocalStorageService();
    }
    if (_preferences == null) {
      _preferences = await SharedPreferences.getInstance();
    }
    return _instance;
  }

  String get usrLogged => _getFromDisk(usrLoggedKey, null);

  set usrLogged(String value) => _saveToDisk(usrLoggedKey, value);

  String get loginDate => _getFromDisk(loginDateKey, null);

  set loginDate(String value) => _saveToDisk(loginDateKey, value);

  void removeUsrLogged() {
    _removeFromDisk(usrLoggedKey);
  }

  void removeLoginDate() {
    _removeFromDisk(loginDateKey);
  }

  dynamic _getFromDisk(String key, dynamic defaultValue) {
    var value = _preferences.get(key) ?? defaultValue;
    return value;
  }

  void _saveToDisk<T>(String key, T content) {
    if (content is String) {
      _preferences.setString(key, content);
    }
    if (content is bool) {
      _preferences.setBool(key, content);
    }
    if (content is int) {
      _preferences.setInt(key, content);
    }
    if (content is double) {
      _preferences.setDouble(key, content);
    }
    if (content is List<String>) {
      _preferences.setStringList(key, content);
    }
  }

  void _removeFromDisk(String key) {
    _preferences.remove(key);
  }
}
