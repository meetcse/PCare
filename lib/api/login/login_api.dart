import 'package:dio/dio.dart';
import 'package:pcare/constants/Endpoints.dart';
import 'package:pcare/models/login/login_model.dart';
import 'package:pcare/network/api_services.dart';

class LoginApi {
  var _apiServices = ApiServices.apiServices;

  Future<LoginModel> loginUser(String userNumber, String password) async {
    LoginModel loginModel;
    try {
      final res = await _apiServices.providePostRequest(
        Endpoints.loginUser,
        {
          'mobilenumber': userNumber,
          'password': password,
        },
      );

      print("RESPONSE : " + res.toString());

      loginModel = LoginModel.fromMap(res);
    } on DioError catch (e) {
      print("Issue in login" "" + e.toString());

      throw e;
    }
    return loginModel;
  }
}
