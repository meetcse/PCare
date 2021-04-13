import 'package:pcare/constants/preferences.dart';
import 'package:pcare/services/SharedPrefsServices.dart';

class AppMethods {
  static void saveLoginDetailsToSharedPrefs(
      String token, String mobilenumber, String password) {
    SharedPrefsServices _sfService = SharedPrefsServices();
    _sfService.setBoolToPref(Preferences.isLoggedIn, true);
    _sfService.setStringToPref(Preferences.mobileNumber, mobilenumber);
    _sfService.setStringToPref(Preferences.password, password);
    _sfService.setStringToPref(Preferences.authToken, token);
  }
}
