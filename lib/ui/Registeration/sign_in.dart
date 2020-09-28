import 'package:flutter/material.dart';
import 'package:pcare/constants/app_theme.dart';
import 'package:pcare/constants/strings.dart';
import 'package:pcare/widgets/back_button_widget.dart';
import 'package:pcare/widgets/empty_app_bar_widget.dart';
import 'package:pcare/widgets/main_app_bar_widget.dart';

class Signin extends StatefulWidget {
  @override
  _SigninState createState() => _SigninState();
}

class _SigninState extends State<Signin> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MainAppBarWidget(
        isColor: false,
        leading: BackButtonWidget(
          isBlackColor: true,
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              UniversalStrings.signIn,
              style: appTheme.textTheme.headline2,
            ),
            //TODO: REMAINING
          ],
        ),
      ), //TODO: Change here
    );
  }
}
