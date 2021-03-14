import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:pcare/Utils/PageUtils.dart';
import 'package:pcare/constants/preferences.dart';
import 'package:pcare/constants/strings.dart';
import 'package:pcare/flushbar_message/flushbar_message.dart';
import 'package:pcare/store/login/login_controller.dart';
import 'package:pcare/ui/Registeration/user_choice.dart';
import 'package:pcare/ui/doctor/doctor_home_page.dart';
import 'package:pcare/ui/patient/HomePage.dart';
import 'package:pcare/widgets/rectangle_button_widget.dart';
import 'package:pcare/widgets/text_field_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Signin extends StatefulWidget {
  @override
  _SigninState createState() => _SigninState();
}

class _SigninState extends State<Signin> {
  int i = 1;
  bool isRemember = false;
  bool canMoveToNextPage = false;
  String email;
  String password;
  LoginController controller = LoginController();
  TextEditingController textEditingControllerForEmail =
      new TextEditingController();
  TextEditingController textEditingControllerForPassword =
      new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // resizeToAvoidBottomInset: false,
      // appBar: MainAppBarWidget(
      //   isColor: false,

      //   // leading: BackButtonWidget(
      //   //   isBlackColor: true,
      //   // ),
      // ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Obx(() {
          return GestureDetector(
            onDoubleTap: () {
              if (i == 1) {
                textEditingControllerForEmail.text = "p@patient.com";
                textEditingControllerForPassword.text = "pat123";
                controller.setEmail(textEditingControllerForEmail.text);
                controller.setPassword(textEditingControllerForPassword.text);
                i++;
              } else if (i == 2) {
                textEditingControllerForEmail.text = "doctor@doctor.com";
                textEditingControllerForPassword.text = "doc123";
                controller.setEmail(textEditingControllerForEmail.text);
                controller.setPassword(textEditingControllerForPassword.text);
                i++;
              } else {
                //TODO: implement receptionist credentials
                i = 1;
                textEditingControllerForEmail.text = "p@patient.com";
                textEditingControllerForPassword.text = "pat123";
                controller.setEmail(textEditingControllerForEmail.text);
                controller.setPassword(textEditingControllerForPassword.text);
              }
            },
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 60,
                ),
                //SIGN IN TEXT
                _buildSignInText(),

                SizedBox(
                  height: 40,
                ),

                //EMAIL FIELD
                controller.loginWith.value == 'email'
                    ? _buildEmailTextField(controller)
                    : Container(),

                //MOBILE NUMBER FIELD
                controller.loginWith.value == 'mobile'
                    ? _buildMobileNumberTextField(controller)
                    : Container(),

                //PASSWORD FIELD
                _buildPasswordTextField(controller),

                //FORGOT PASSWORD
                Container(
                  margin: EdgeInsets.only(left: 14, right: 14),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        child: GestureDetector(
                          onTap: () {
                            //TODO: Add functionality here
                          },
                          child: Text(
                            UniversalStrings.forgetPassword,
                            style: Theme.of(context).textTheme.headline6,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                //sign in button
                _buildSignInButton(controller),

                //OR text
                Container(
                  padding: EdgeInsets.only(
                    top: 10,
                    bottom: 10,
                    // left: MediaQuery.of(context).size.width * 0.47,
                    // right: MediaQuery.of(context).size.width * 0.49,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(UniversalStrings.or,
                          style: Theme.of(context).textTheme.headline6,
                          maxLines: 1),
                    ],
                  ),
                ),

                //FB AND GOOGLE SIGN IN
                Expanded(
                  flex: 0,
                  child: Container(
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
                        Expanded(
                          child: RectangleButtonWidget(
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
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                //Login with mobile or email and crete acc text
                Flexible(
                  fit: FlexFit.loose,
                  // flex: 0,
                  child: _buildBottomTextItems(controller),
                ),
              ],
            ),
          );
        }),
      ),
    );
  }

  Widget _buildBottomTextItems(LoginController controller) {
    return Container(
      // alignment: Alignment.bottomCenter,
      margin: const EdgeInsets.only(top: 10, bottom: 10, left: 8, right: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.end,
        mainAxisSize: MainAxisSize.min,
        children: [
          controller.loginWith.value == 'email'
              ? Container(
                  padding: EdgeInsets.only(bottom: 8),
                  child: GestureDetector(
                    onTap: () {
                      print("ENTER");
                      controller.setLoginWith('mobile');
                    },
                    child: Text(
                      UniversalStrings.loginWithMobile,
                      style: Theme.of(context)
                          .textTheme
                          .headline6
                          .copyWith(decoration: TextDecoration.underline),
                    ),
                  ),
                )
              : Container(),
          controller.loginWith.value == 'mobile'
              ? Container(
                  padding: EdgeInsets.only(bottom: 8),
                  child: GestureDetector(
                    onTap: () {
                      print("ENTERED");

                      controller.setLoginWith('email');
                    },
                    child: Text(
                      UniversalStrings.loginWithEmail,
                      style: Theme.of(context)
                          .textTheme
                          .headline6
                          .copyWith(decoration: TextDecoration.underline),
                    ),
                  ),
                )
              : Container(),
          Container(
            padding: EdgeInsets.only(bottom: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  UniversalStrings.dontHaveAccount,
                  style: Theme.of(context).textTheme.headline6,
                ),
                Container(
                  padding: EdgeInsets.only(left: 2),
                  child: GestureDetector(
                    child: Text(
                      UniversalStrings.createAccount,
                      style: Theme.of(context)
                          .textTheme
                          .subtitle1
                          .copyWith(decoration: TextDecoration.underline),
                    ),
                    onTap: () {
                      PageUtils.pushPage(UserChoice());
                    },
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _buildSignInButton(LoginController controller) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 14, vertical: 8),
      child: RectangleButtonWidget(
        isImage: false,
        onPressed: () async {
          //TODO: ADD functionality for validating and then route
          controller.validateAll();
          if (controller.canLogin) {
            SharedPreferences prefs = await SharedPreferences.getInstance();
            prefs.setBool(Preferences.isLoggedIn, true);

            if (controller.email.value == "doctor@doctor.com" &&
                controller.password.value == "doc123") {
              prefs.setString(Preferences.userType, Preferences.doctor);
            } else if (controller.email.value == "p@patient.com" &&
                controller.password.value == "pat123") {
              prefs.setString(Preferences.userType, Preferences.patient);
            }

            // controller.reset();

            if (prefs.getString(Preferences.userType) == Preferences.doctor) {
              PageUtils.pushPageAndRemoveCurrentPage(DoctorHomePage());
            } else if (prefs.getString(Preferences.userType) ==
                Preferences.patient) {
              //TODO: ADD EMAIL AND PASS TO SHARED PREF WHEN
              //LOGIN DURING API
              PageUtils.pushPageAndRemoveCurrentPage(HomePage());
            } else {
              FlushbarMessage.errorMessage(
                context,
                "No Valid User",
              );
            }

            // FlushbarMessage.successMessage(context, " ");
          } else {
            FlushbarMessage.errorMessage(
              context,
              controller.emailError.value != null
                  ? controller.emailError.value
                  : controller.passwordError.value != null
                      ? controller.passwordError.value
                      : "TRY AGAIN",
            );
          }
        },
        childText: UniversalStrings.signIn,
        width: MediaQuery.of(context).size.width,
      ),
    );
  }

  Widget _buildPasswordTextField(LoginController controller) {
    return TextFieldWidget(
      textEditingController: textEditingControllerForPassword,
      labelText: UniversalStrings.password,
      isError: controller.passwordError.value == null ||
              controller.passwordError.value == ''
          ? false
          : true,
      errorText: controller.passwordError.value,
      isObscureText: true,
      onChanged: (value) {
        controller.setPassword(value);
      },
    );
  }

  Widget _buildMobileNumberTextField(LoginController controller) {
    return TextFieldWidget(
      isError: controller.mobileNumberError.value == null ||
              controller.mobileNumberError.value == ''
          ? false
          : true,
      labelText: UniversalStrings.mobileNumber,
      errorText: controller.mobileNumberError.value,
      textInputFormatter: [
        FilteringTextInputFormatter.digitsOnly,
      ],
      onChanged: (value) {
        controller.setMobileNumber(value);
      },
      textInputType: TextInputType.number,
    );
  }

  Widget _buildEmailTextField(LoginController controller) {
    return TextFieldWidget(
      textEditingController: textEditingControllerForEmail,
      isError: controller.emailError.value == null ||
              controller.emailError.value == ''
          ? false
          : true,
      labelText: UniversalStrings.email,
      errorText: controller.emailError.value,
      onChanged: (value) {
        controller.setEmail(value);
      },
    );
  }

  Widget _buildSignInText() {
    return Container(
      margin: EdgeInsets.only(top: 0, left: 20),
      child: Row(
        children: [
          Text(
            UniversalStrings.signIn,
            style: Theme.of(context).textTheme.headline2.copyWith(
                  fontSize: 44,
                ),
          ),
        ],
      ),
    );
  }
}
