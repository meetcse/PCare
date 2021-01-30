import 'package:flutter/material.dart';
import 'package:pcare/constants/preferences.dart';
import 'package:pcare/routes/animation_route.dart';
import 'package:pcare/routes/routes.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatelessWidget {
  changeScreen(BuildContext context) {
    Future.delayed(Duration(seconds: 5), () async {
      SharedPreferences _prefs = await SharedPreferences.getInstance();
      if (_prefs.getBool(Preferences.isLoggedIn) == null ||
          !_prefs.getBool(Preferences.isLoggedIn)) {
        Navigator.pushReplacement(
          context,
          AnimationRoute(builder: (context) {
            return routes['/sign_in'](context);
          }),
        );
      } else {
        //TODO: Navigate after checking doctor or patient

        Navigator.pushReplacement(
          context,
          AnimationRoute(builder: (context) {
            return routes['/home_page'](context);
          }),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    changeScreen(context);
    return Scaffold(
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
