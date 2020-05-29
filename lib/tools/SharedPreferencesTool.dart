import 'package:shared_preferences/shared_preferences.dart';

const String SEARCH_HISTORY = "SEARCH_HISTORY";
const String USER_ID = "USER_ID";
const String USER_NAME = "USER_NAME";
const String USER_TEL = "USER_TEL";
const String USER_SALT = "USER_SALT";

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

  remove(String key) {
    prefs.remove(key);
  }

  setStringList(String key, List<String> value) {
    prefs.setStringList(key, value);
  }

  ///  维护一个不空,不重复的List<String>
  /// [key] : list的key
  /// [itemKey] : 单个元素的key
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
    prefs.remove(key);
    prefs.setStringList(key, temp);
  }

  /// 删除单个item
  /// [key] : list的key
  /// [itemKey] : 单个元素的key
  bool removeStringList(String key, String itemKey) {
    List<String> temp = prefs.getStringList(key);
    bool flag = false;
    if (temp == null || temp.length == 0) {
      flag = false;
    } else {
      if (temp.contains(itemKey)) {
        temp.remove(itemKey);

        prefs.remove(key);
        prefs.setStringList(key, temp);

        flag = true;
      } else {
        flag = false;
      }
    }
    return flag;
  }

  cleanStringList(String key) {
    List<String> temp = prefs.getStringList(key);
    if (temp != null && temp.length != 0) {
      prefs.remove(key);
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
