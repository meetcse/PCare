import 'package:flutter/material.dart';
import 'package:pcare/Utils/PageUtils.dart';
import 'package:pcare/constants/preferences.dart';
import 'package:pcare/ui/Registeration/sign_in.dart';
import 'package:pcare/ui/doctor/doctor_home_page.dart';
import 'package:pcare/ui/patient/HomePage.dart';
import 'package:pcare/ui/reception/reception_home_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatelessWidget {
  changeScreen(BuildContext context) {
    Future.delayed(Duration(seconds: 5), () async {
      SharedPreferences _prefs = await SharedPreferences.getInstance();
      if (_prefs.getBool(Preferences.isLoggedIn) == null ||
          !_prefs.getBool(Preferences.isLoggedIn)) {
        PageUtils.pushPageAndRemoveCurrentPage(Signin());
      } else {
        if (_prefs.getString(Preferences.userType) == Preferences.doctor) {
          PageUtils.pushPageAndRemoveCurrentPage(DoctorHomePage());
        } else if (_prefs.getString(Preferences.userType) ==
            Preferences.patient) {
          //TODO: ADD EMAIL AND PASS TO SHARED PREF WHEN
          //LOGIN DURING API
          PageUtils.pushPageAndRemoveCurrentPage(HomePage());
        } else if (_prefs.getString(Preferences.userType) ==
            Preferences.reception) {
          //TODO: ADD EMAIL AND PASS TO SHARED PREF WHEN
          //LOGIN DURING API
          PageUtils.pushPageAndRemoveCurrentPage(ReceptionHomePage());
        } else {
          PageUtils.pushPageAndRemoveCurrentPage(Signin());
        }
        //TODO: Navigate after checking doctor or patient
        // PageUtils.pushPageAndRemoveCurrentPage(HomePage());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    changeScreen(context);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      extendBody: false,
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Image(
          image: AssetImage("assets/splash/splash.png"),
          fit: BoxFit.fill,
        ),
      ),
    );
  }
}
