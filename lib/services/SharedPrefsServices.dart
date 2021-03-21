import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefsServices {
  static SharedPreferences _preferences;

  SharedPrefsServices() {
    getSPInstance();
  }

  Future<SharedPreferences> getSPInstance() async {
    if (_preferences == null) {
      _preferences = await SharedPreferences.getInstance();
      return _preferences;
    }
    return _preferences;
  }

  void setStringToPref(String key, String value) {
    if (_preferences == null) {}
    _preferences.setString(key, value);
  }

  String getStringFromPref(String key) {
    return _preferences.getString(key);
  }

  void setBoolToPref(String key, bool value) {
    _preferences.setBool(key, value);
  }

  bool getBoolFromPref(String key) {
    return _preferences.getBool(key);
  }
}
