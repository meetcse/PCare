import 'package:flutter/material.dart';
import 'package:pcare/HomePage.dart';
import 'package:pcare/routes/routes.dart';
import 'package:pcare/ui/Registeration/sign_in.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'P Care',
      routes: routes,
      // initialRoute: '/sign_in',
      home: Scaffold(
        body: Signin(), //TODO: Change here
      ),
    );
  }
}
