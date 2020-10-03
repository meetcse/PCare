import 'package:flutter/material.dart';
import 'package:pcare/constants/app_theme.dart';
import 'package:pcare/constants/strings.dart';
import 'package:pcare/widgets/back_button_widget.dart';
import 'package:pcare/widgets/empty_app_bar_widget.dart';
import 'package:pcare/widgets/main_app_bar_widget.dart';
import 'package:pcare/widgets/radio_button_widget.dart';
import 'package:pcare/widgets/rectangle_button_widget.dart';
import 'package:pcare/widgets/text_field_widget.dart';

class Signin extends StatefulWidget {
  @override
  _SigninState createState() => _SigninState();
}

class _SigninState extends State<Signin> {
  bool isEmailError = false;
  bool isPasswordError = false;
  bool isRemember = false;

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
            Container(
              margin: EdgeInsets.only(top: 30, left: 20),
              child: Row(
                children: [
                  Text(
                    UniversalStrings.signIn,
                    style: appTheme.textTheme.headline2.copyWith(
                      fontSize: 28,
                    ),
                  ),
                ],
              ),
            ),
            TextFieldWidget(
              isError: isEmailError,
              labelText: UniversalStrings.email,
              errorText: isEmailError ? UniversalStrings.enterValidEmail : null,
              onChanged: (value) {
                bool validate = RegExp(
                        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                    .hasMatch(value);
                if (validate) {
                  setState(() {
                    isEmailError = false;
                  });
                } else {
                  setState(() {
                    isEmailError = true;
                  });
                }
              },
            ),
            TextFieldWidget(
              labelText: UniversalStrings.password,
              isError: isPasswordError,
              errorText:
                  isPasswordError ? UniversalStrings.enterValidPassword : null,
              isObscureText: true,
              onChanged: (value) {
                if (value.length < 6) {
                  setState(() {
                    isPasswordError = true;
                  });
                } else {
                  setState(() {
                    isPasswordError = false;
                  });
                }
              },
            ),
            Container(
              margin: EdgeInsets.only(left: 14, right: 14),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    // margin: EdgeInsets.only(left: 8),
                    child: RadioButtonWidget(
                      iconSelected: isRemember,
                      groupValue: UniversalStrings.remember,
                      itemText: UniversalStrings.remember,
                      onChanged: (value) {
                        setState(() {
                          isRemember = !isRemember;
                        });
                      },
                    ),
                  ),
                  Container(
                    child: GestureDetector(
                      onTap: () {
                        //TODO: Add functionality here
                      },
                      child: Text(
                        UniversalStrings.forgetPassword,
                        style: appTheme.textTheme.headline6,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 14, vertical: 8),
              child: RectangleButtonWidget(
                isImage: false,
                onPressed: () {
                  //TODO: ADD functionality for validating and then route
                  Navigator.of(context).pushNamed('/home_page');
                },
                childText: UniversalStrings.signIn,
                width: MediaQuery.of(context).size.width,
              ),
            ),
            Container(
              padding: EdgeInsets.only(
                  top: 10,
                  bottom: 10,
                  left: MediaQuery.of(context).size.width * 0.47,
                  right: MediaQuery.of(context).size.width * 0.49),
              child: Text(UniversalStrings.or,
                  style: appTheme.textTheme.headline6, maxLines: 1),
            ),
            Container(
              padding: EdgeInsets.only(top: 10, bottom: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  RectangleButtonWidget(
                    isImage: true,
                    imageOutsideBorderWidth:
                        MediaQuery.of(context).size.width * 0.48,
                    image: "assets/images/fb.png",
                    imageInsideWidth: MediaQuery.of(context).size.width * 0.45,
                    onPressed: () {
                      //TODO: Add functionality
                      print("Pressed FB");
                    },
                  ),
                  RectangleButtonWidget(
                    isImage: true,
                    imageOutsideBorderWidth:
                        MediaQuery.of(context).size.width * 0.48,
                    image: "assets/images/gplus.png",
                    imageInsideWidth: MediaQuery.of(context).size.width * 0.45,
                    onPressed: () {
                      //TODO: Add functionality
                      print("Pressed GPlus");
                    },
                  ),
                ],
              ),
            ),
            Flexible(
              child: Container(
                margin: EdgeInsets.only(top: 10, bottom: 20, left: 8, right: 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      padding: EdgeInsets.only(bottom: 8),
                      child: GestureDetector(
                        onTap: () {
                          //TODO: Add functionality
                        },
                        child: Text(
                          UniversalStrings.loginWithMobile,
                          style: appTheme.textTheme.headline6,
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(bottom: 8),
                      child: GestureDetector(
                        onTap: () {
                          //TODO: Add functionality
                        },
                        child: Text(
                          UniversalStrings.loginWithEmail,
                          style: appTheme.textTheme.headline6,
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(bottom: 8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            UniversalStrings.dontHaveAccount,
                            style: appTheme.textTheme.headline6,
                          ),
                          Container(
                            padding: EdgeInsets.only(left: 2),
                            child: GestureDetector(
                              child: Text(
                                UniversalStrings.createAccount,
                                style: appTheme.textTheme.subtitle1,
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
