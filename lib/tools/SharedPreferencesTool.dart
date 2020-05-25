import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesTool {
  SharedPreferences prefs;

  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  SharedPreferencesTool._() {
    init();
  }

  static SharedPreferencesTool _instance;

  static SharedPreferencesTool getInstance() {
    if (_instance == null) {
      _instance = SharedPreferencesTool._();
    }
    return _instance;
  }

  init() async {
    prefs = await _prefs;
  }

  setBool(String key, bool value) {
    prefs.setBool(key, value);
  }

  setDouble(String key, double value) {
    prefs.setDouble(key, value);
  }

  setInt(String key, int value) {
    prefs.setInt(key, value);
  }

  setString(String key, String value) {
    prefs.setString(key, value);
  }

  setStringList(String key, List<String> value) {
    prefs.setStringList(key, value);
  }

  /**
   * 维护一个不空,不重复的List<String>
   * */
  addStringList(String key, String value) {
    List<String> temp = prefs.getStringList(key);
    if (temp == null) {
      temp = new List<String>();
      temp.add(value);
    } else {
      if (!temp.contains(value)) {
        temp.add(value);
      }
    }
  }

  bool getBool(String key) {
    return prefs.getBool(key);
  }

  int getInt(String key) {
    return prefs.getInt(key);
  }

  String getString(String key) {
    return prefs.getString(key);
  }

  double getDouble(String key) {
    return prefs.getDouble(key);
  }

  List<String> getStringList(String key) {
    return prefs.getStringList(key);
  }
}
