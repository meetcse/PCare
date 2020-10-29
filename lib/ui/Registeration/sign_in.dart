import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:pcare/constants/app_theme.dart';
import 'package:pcare/constants/strings.dart';
import 'package:pcare/flushbar_message/flushbar_message.dart';
import 'package:pcare/store/login/login_store.dart';
import 'package:pcare/widgets/back_button_widget.dart';
import 'package:pcare/widgets/empty_app_bar_widget.dart';
import 'package:pcare/widgets/main_app_bar_widget.dart';
import 'package:pcare/widgets/radio_button_widget.dart';
import 'package:pcare/widgets/rectangle_button_widget.dart';
import 'package:pcare/widgets/text_field_widget.dart';
import 'package:provider/provider.dart';

class Signin extends StatefulWidget {
  @override
  _SigninState createState() => _SigninState();
}

class _SigninState extends State<Signin> {
  bool isRemember = false;
  bool canMoveToNextPage = false;
  String email;
  String password;
  LoginStore _loginStore;
  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    _loginStore = Provider.of<LoginStore>(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: MainAppBarWidget(
        isColor: false,
        // leading: BackButtonWidget(
        //   isBlackColor: true,
        // ),
      ),
      body: Observer(
        builder: (context) => SingleChildScrollView(
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
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
                  isError: _loginStore.emailError == null ? false : true,
                  labelText: UniversalStrings.email,
                  errorText: _loginStore.emailError,
                  onChanged: (value) {
                    _loginStore.setEmail(value);
                  },
                ),
                TextFieldWidget(
                  labelText: UniversalStrings.password,
                  isError: _loginStore.passwordError == null ? false : true,
                  errorText: _loginStore.passwordError,
                  isObscureText: true,
                  onChanged: (value) {
                    _loginStore.setPassword(value);
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
                //sign in button
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                  child: RectangleButtonWidget(
                    isImage: false,
                    onPressed: () {
                      //TODO: ADD functionality for validating and then route

                      if (_loginStore.canLogin) {
                        //TODO: CHange here with pushReplacement
                        // Navigator.of(context).pushNamed('/home_page');
                        FlushbarMessage.successMessage(context, " ");
                      } else {
                        FlushbarMessage.errorMessage(
                          context,
                          _loginStore.emailError != null
                              ? _loginStore.emailError
                              : _loginStore.passwordError != null
                                  ? _loginStore.passwordError
                                  : "TRY AGAIN",
                        );
                      }
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
                        imageInsideWidth:
                            MediaQuery.of(context).size.width * 0.45,
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
                        imageInsideWidth:
                            MediaQuery.of(context).size.width * 0.45,
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
                    margin:
                        EdgeInsets.only(top: 10, bottom: 20, left: 8, right: 8),
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
        ),
      ),
    );
  }
}
