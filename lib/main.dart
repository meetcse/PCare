import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:pcare/constants/app_colors.dart';
import 'package:pcare/constants/app_theme.dart';
import 'package:pcare/ui/doctor/patient/add_patient_observation.dart';
import 'package:pcare/services/SharedPrefsServices.dart';
import 'package:pcare/store/login/login_controller.dart';
import 'package:pcare/ui/splash_screen/splash_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  // SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
  //   // statusBarColor: UniversalColors.gradientColorStart,
  //   statusBarBrightness: Brightness.dark,
  //   statusBarIconBrightness: Brightness.dark,
  // ));
  Get.put(LoginController());

  SharedPrefsServices _sharedPrefServces = SharedPrefsServices();
  _sharedPrefServces.getSPInstance();
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
      home: SplashScreen(),
    );
  }
}
