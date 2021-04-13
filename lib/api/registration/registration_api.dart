import 'package:dio/dio.dart';
import 'package:pcare/constants/Endpoints.dart';
import 'package:pcare/models/login/login_model.dart';
import 'package:pcare/models/user/user_model.dart';
import 'package:pcare/network/api_services.dart';

class RegistrationApi {
  var _apiServices = ApiServices.apiServices;

  Future<LoginModel> registerUser(UserModel user) async {
    LoginModel loginModel;
    try {
      final res = await _apiServices.providePostRequest(
          Endpoints.registerUser, user.toMap());

      print("RESPONSE : " + res.toString());

      if (res['error'] != null) {
        throw res['error'];
      } else {
        loginModel = LoginModel.fromMap(res);
      }
    } on DioError catch (e) {
      print("Issue in login" "" + e.toString());

      throw e;
    }
    return loginModel;
  }
}
