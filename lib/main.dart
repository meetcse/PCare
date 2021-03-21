import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:pcare/constants/app_theme.dart';
import 'package:pcare/ui/doctor/patient/add_patient_observation.dart';
import 'package:pcare/ui/splash_screen/splash_screen.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarBrightness: Brightness.light));
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'P Care',

      theme: CustomTheme.customTheme(context),
      // onGenerateRoute: (settings) {
      //   print("HELLO");
      //   return PageRouteBuilder(pageBuilder: (context, a1, a2) {
      //     return FadeThroughTransition(
      //       animation: null,
      //       secondaryAnimation: null,
      //       child: routes[settings.name](context),
      //     );
      //   });
      // },
      // initialRoute: '/sign_in',
      home: Scaffold(
        body: SplashScreen(),
      ),
    );
  }
}
