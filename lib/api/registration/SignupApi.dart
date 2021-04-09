import 'package:dio/dio.dart';
import 'package:pcare/constants/Endpoints.dart';
import 'package:pcare/models/login/login_model.dart';
import 'package:pcare/models/signup/SignupModel.dart';
import 'package:pcare/network/api_services.dart';

class SignupApi {
  var _apiServices = ApiServices.apiServices;

  Future<LoginModel> registerUser(SignupModel signupModel) async {
    LoginModel _signupModel;
    try {
      final _res = await _apiServices.providePostRequest(
        Endpoints.signup,
        signupModel.toMap(),
      );

      print("RESPONSE : " + _res.toString());

      _signupModel = LoginModel.fromMap(_res);
    } on DioError catch (e) {
      print("Issue in sign up" + e.toString());

      throw e;
    }
    return _signupModel;
  }
}
