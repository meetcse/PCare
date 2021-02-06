import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:pcare/constants/app_colors.dart';
import 'package:pcare/constants/app_theme.dart';
import 'package:pcare/constants/preferences.dart';
import 'package:pcare/constants/strings.dart';
import 'package:pcare/flushbar_message/flushbar_message.dart';
import 'package:pcare/routes/animation_route.dart';
import 'package:pcare/routes/routes.dart';
import 'package:pcare/store/login/login_store.dart';
import 'package:pcare/widgets/custom_progress_indicator_widget.dart';
import 'package:pcare/widgets/main_app_bar_widget.dart';
import 'package:pcare/widgets/rectangle_button_widget.dart';
import 'package:pcare/widgets/text_field_widget.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    _loginStore = Provider.of<LoginStore>(context);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _loginStore.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      // appBar: MainAppBarWidget(
      //   isColor: false,

      //   // leading: BackButtonWidget(
      //   //   isBlackColor: true,
      //   // ),
      // ),
      body: Observer(
        builder: (context) => SingleChildScrollView(
          physics: BouncingScrollPhysics(),
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
              _loginStore.loginWith == 'email'
                  ? _buildEmailTextField()
                  : Container(),

              //MOBILE NUMBER FIELD
              _loginStore.loginWith == 'mobile'
                  ? _buildMobileNumberTextField()
                  : Container(),

              //PASSWORD FIELD
              _buildPasswordTextField(),

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
              _buildSignInButton(),

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
                child: _buildBottomTextItems(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBottomTextItems() {
    return Container(
      // alignment: Alignment.bottomCenter,
      margin: const EdgeInsets.only(top: 10, bottom: 10, left: 8, right: 8),
      child: Observer(
        builder: (context) => Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.end,
          mainAxisSize: MainAxisSize.min,
          children: [
            _loginStore.loginWith == 'email'
                ? Container(
                    padding: EdgeInsets.only(bottom: 8),
                    child: GestureDetector(
                      onTap: () {
                        print("ENTER");
                        _loginStore.setLoginWith('mobile');
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
            _loginStore.loginWith == 'mobile'
                ? Container(
                    padding: EdgeInsets.only(bottom: 8),
                    child: GestureDetector(
                      onTap: () {
                        print("ENTERED");

                        _loginStore.setLoginWith('email');
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
                      onTap: () => Navigator.of(context)
                          .push(AnimationRoute(builder: (context) {
                        return routes['/sign_up'](context);
                      })),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildSignInButton() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 14, vertical: 8),
      child: RectangleButtonWidget(
        isImage: false,
        onPressed: () async {
          //TODO: ADD functionality for validating and then route
          _loginStore.validateAll();
          if (_loginStore.canLogin) {
            SharedPreferences prefs = await SharedPreferences.getInstance();
            prefs.setBool(Preferences.isLoggedIn, true);
            _loginStore.reset();

            //TODO: ADD EMAIL AND PASS TO SHARED PREF WHEN
            //LOGIN DURING API
            Navigator.of(context)
                .pushReplacement(AnimationRoute(builder: (context) {
              return routes['/home_page'](context);
            }));
            // FlushbarMessage.successMessage(context, " ");
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
    );
  }

  Widget _buildPasswordTextField() {
    return TextFieldWidget(
      labelText: UniversalStrings.password,
      isError: _loginStore.passwordError == null ? false : true,
      errorText: _loginStore.passwordError,
      isObscureText: true,
      onChanged: (value) {
        _loginStore.setPassword(value);
      },
    );
  }

  Widget _buildMobileNumberTextField() {
    return TextFieldWidget(
      isError: _loginStore.mobileNumberError == null ? false : true,
      labelText: UniversalStrings.mobileNumber,
      errorText: _loginStore.mobileNumberError,
      onChanged: (value) {
        _loginStore.setMobileNumber(value);
      },
      textInputType: TextInputType.number,
    );
  }

  Widget _buildEmailTextField() {
    return TextFieldWidget(
      isError: _loginStore.emailError == null ? false : true,
      labelText: UniversalStrings.email,
      errorText: _loginStore.emailError,
      onChanged: (value) {
        _loginStore.setEmail(value);
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
