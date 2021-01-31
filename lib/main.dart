import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pcare/constants/app_theme.dart';
import 'package:pcare/routes/routes.dart';
import 'package:pcare/store/login/login_store.dart';
import 'package:pcare/store/patients/patient_home_store.dart';
import 'package:pcare/ui/splash_screen/splash_screen.dart';
import 'package:provider/provider.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarBrightness: Brightness.light));
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
//Only use this method when you have to use value of store anywhere in the app.
//or else define object of store in that screen only if needed
  final LoginStore _loginStore = LoginStore();
  final PatientHomeStore _patientHomeStore = PatientHomeStore();
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<LoginStore>.value(
          value: _loginStore,
        ),
        Provider<PatientHomeStore>.value(
          value: _patientHomeStore,
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'P Care',
        routes: routes,
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
      ),
    );
  }
}
