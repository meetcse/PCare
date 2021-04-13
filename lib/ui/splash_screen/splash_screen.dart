import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pcare/Utils/PageUtils.dart';
import 'package:pcare/api/login/login_api.dart';
import 'package:pcare/constants/preferences.dart';
import 'package:pcare/services/SharedPrefsServices.dart';
import 'package:pcare/store/login/login_controller.dart';
import 'package:pcare/ui/Registeration/sign_in.dart';
import 'package:pcare/ui/doctor/doctor_home_page.dart';
import 'package:pcare/ui/patient/HomePage.dart';
import 'package:pcare/ui/reception/reception_home_page.dart';
import 'package:pcare/widgets/custom_progress_indicator_widget.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  SharedPrefsServices _sfService = SharedPrefsServices();

  bool _isLoading = false;
  LoginController controller = Get.find<LoginController>();

  @override
  Widget build(BuildContext context) {
    changeScreen(context);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      extendBody: false,
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    return Stack(
      children: [
        _buildSplashImage(),
        _isLoading ? _progressIndicator() : Container(),
      ],
    );
  }

  Widget _progressIndicator() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Spacer(),
        Expanded(child: CustomProgressIndicatorWidget()),
      ],
    );
  }

  Widget _buildSplashImage() {
    return Container(
      height: MediaQuery.of(Get.context).size.height,
      width: MediaQuery.of(Get.context).size.width,
      child: Image(
        image: AssetImage("assets/splash/splash.png"),
        fit: BoxFit.fill,
      ),
    );
  }

  changeScreen(BuildContext context) {
    Future.delayed(Duration(seconds: 3), () async {
      _isLoading = true;
      if (mounted) setState(() {});
      if (_sfService.getBoolFromPref(Preferences.isLoggedIn) == null ||
          !_sfService.getBoolFromPref(Preferences.isLoggedIn)) {
        _gotoSignInScreen();
      } else {
        try {
          LoginApi _loginApi = LoginApi();
          controller.loginModel = await _loginApi.loginUser(
              _sfService.getStringFromPref(Preferences.mobileNumber),
              _sfService.getStringFromPref(Preferences.password));

          if (controller.loginModel.user.userType.toLowerCase() == "patient") {
            _saveTokenToSharedPrefs(controller.loginModel.token);
            _gotoPatientHomePage();
          } else if (controller.loginModel.user.userType.toLowerCase() ==
              "doctor") {
            _saveTokenToSharedPrefs(controller.loginModel.token);
            _gotoDoctorHomePage();
          } else if (controller.loginModel.user.userType.toLowerCase() ==
              "receptionist") {
            _saveTokenToSharedPrefs(controller.loginModel.token);
            _gotoReceptionistHomePage();
          }
        } catch (error) {
          PageUtils.pushPageAndRemoveCurrentPage(Signin());
        }
      }
    });
  }

  void _gotoSignInScreen() {
    PageUtils.pushPageAndRemoveCurrentPage(Signin());
  }

  void _gotoPatientHomePage() {
    PageUtils.pushPageAndRemoveAll(HomePage());
  }

  void _gotoDoctorHomePage() {
    PageUtils.pushPageAndRemoveAll(DoctorHomePage());
  }

  void _gotoReceptionistHomePage() {
    PageUtils.pushPageAndRemoveAll(ReceptionHomePage());
  }

  void _saveTokenToSharedPrefs(String token) {
    _sfService.setStringToPref(Preferences.authToken, token);
  }
}
