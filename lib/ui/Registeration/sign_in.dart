import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:pcare/Utils/PageUtils.dart';
import 'package:pcare/api/login/login_api.dart';
import 'package:pcare/constants/app_colors.dart';
import 'package:pcare/constants/preferences.dart';
import 'package:pcare/constants/strings.dart';
import 'package:pcare/flushbar_message/flushbar_message.dart';
import 'package:pcare/models/login/login_model.dart';
import 'package:pcare/services/SharedPrefsServices.dart';
import 'package:pcare/store/login/login_controller.dart';
import 'package:pcare/ui/Registeration/user_choice.dart';
import 'package:pcare/ui/doctor/doctor_home_page.dart';
import 'package:pcare/ui/patient/HomePage.dart';
import 'package:pcare/ui/reception/reception_home_page.dart';
import 'package:pcare/widgets/custom_progress_indicator_widget.dart';
import 'package:pcare/widgets/rectangle_button_widget.dart';
import 'package:pcare/widgets/text_field_widget.dart';

class Signin extends StatefulWidget {
  @override
  _SigninState createState() => _SigninState();
}

class _SigninState extends State<Signin> {
  bool isRemember = false;
  bool canMoveToNextPage = false;
  String email;
  String password;
  LoginController controller = Get.find<LoginController>();
  TextEditingController textEditingControllerForEmail =
      new TextEditingController();
  TextEditingController textEditingControllerForPassword =
      new TextEditingController();

  bool _isLoading = false;
  SharedPrefsServices _sfService = SharedPrefsServices();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildChildWidget(),
    );
  }

  Widget _buildChildWidget() {
    return Stack(
      children: [
        _buildBody(),
        _buildProgressIndicator(),
      ],
    );
  }

  Widget _buildBody() {
    return LayoutBuilder(
      builder: (context, constraint) => SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: ConstrainedBox(
          constraints: BoxConstraints(minHeight: constraint.maxHeight),
          child: IntrinsicHeight(
            child: Obx(() {
              return Column(
                // mainAxisSize: MainAxisSize.min,
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

                  _buildMobileNumberTextField(controller),

                  //PASSWORD FIELD
                  _buildPasswordTextField(controller),

                  //sign in button
                  Expanded(
                      child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      //FORGOT PASSWORD
                      _forgotPassword(),
                      //Login with mobile or email and crete acc text
                      // _bottomWidget(),
                      _buildBottomTextItems(controller),
                      _buildSignInButton(controller),

                      SizedBox(height: 30),
                    ],
                  )),
                ],
              );
            }),
          ),
        ),
      ),
    );
  }

  Widget _buildProgressIndicator() {
    return Visibility(
      visible: _isLoading,
      child: CustomProgressIndicatorWidget(),
    );
  }

  Widget _orText() {
    return Container(
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
              style: Theme.of(context).textTheme.headline6, maxLines: 1),
        ],
      ),
    );
  }

  Widget _forgotPassword() {
    return Container(
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
                style: Theme.of(context)
                    .textTheme
                    .headline6
                    .copyWith(decoration: TextDecoration.underline),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _bottomWidget() {
    return Flexible(
      fit: FlexFit.loose,
      // flex: 0,
      child: _buildBottomTextItems(controller),
    );
  }

  Widget _buildFbAndGoogleSignInButton() {
    return Expanded(
      flex: 0,
      child: Container(
        padding: EdgeInsets.only(top: 10, bottom: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            RectangleButtonWidget(
              childText: '',
              // isImage: true,
              // imageOutsideBorderWidth: MediaQuery.of(context).size.width * 0.48,
              image: "assets/images/fb.png",
              // imageInsideWidth: MediaQuery.of(context).size.width * 0.45,
              onPressed: () {
                print("Pressed FB");
              },
            ),
            Expanded(
              child: RectangleButtonWidget(
                childText: '',
                // isImage: true,
                // imageOutsideBorderWidth:
                //     MediaQuery.of(context).size.width * 0.48,
                image: "assets/images/gplus.png",
                // imageInsideWidth: MediaQuery.of(context).size.width * 0.45,
                onPressed: () {
                  print("Pressed GPlus");
                },
              ),
            ),
          ],
        ),
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
                    onTap: _gotoUserChoiceScreen,
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _loginWithEmailText() {
    return Container(
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
    );
  }

  Widget _loginWithMobileText() {
    return Container(
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
    );
  }

  Widget _buildSignInButton(LoginController controller) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 14, vertical: 0),
      child: RectangleButtonWidget(
        onPressed: () {
          _onSignInButtonPressed();
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
        LengthLimitingTextInputFormatter(10),
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

  //methods

  void _onSignInButtonPressed() {
    controller.validateAll();
    if (controller.canLogin) {
      _changeLoading(true);
      _callApi();
    } else {
      FlushbarMessage.errorMessage(
        context,
        controller.mobileNumberError.value != null
            ? controller.mobileNumberError.value
            : controller.passwordError.value != null
                ? controller.passwordError.value
                : "TRY AGAIN",
      );
    }
  }

  void _callApi() async {
    LoginApi _loginApi = LoginApi();
    try {
      controller.loginModel = await _loginApi.loginUser(
          controller.mobileNumber.value, controller.password.value);

      if (controller.loginModel.user.userType.toLowerCase() == "patient") {
        _saveDetailsToSharedPrefs(controller.loginModel.token);
        _gotoPatientHomePage();
      } else if (controller.loginModel.user.userType.toLowerCase() ==
          "doctor") {
        _saveDetailsToSharedPrefs(controller.loginModel.token);
        _gotoDoctorHomePage();
      } else if (controller.loginModel.user.userType.toLowerCase() ==
          "receptionist") {
        _saveDetailsToSharedPrefs(controller.loginModel.token);
        _gotoReceptionistHomePage();
      }
      _changeLoading(false);
    } catch (error) {
      _changeLoading(false);
      print("ERROR IN LOGIN : " + error.toString());
      FlushbarMessage.errorMessage(Get.context, "Error in login");
    }
  }

  void _changeLoading(bool isLoading) {
    _isLoading = isLoading;
    setState(() {});
  }

  void _gotoUserChoiceScreen() {
    PageUtils.pushPage(UserChoice());
  }

  void _gotoPatientHomePage() {
    PageUtils.pushPageAndRemoveAll(HomePage());
  }

  void _gotoDoctorHomePage() {
    PageUtils.pushPageAndRemoveAll(DoctorHomePage());
  }

  void _gotoReceptionistHomePage() {
    PageUtils.pushPageAndRemoveAll(ReceptionHomePage());
  }

  void _saveDetailsToSharedPrefs(String token) {
    _sfService.setBoolToPref(Preferences.isLoggedIn, true);
    _sfService.setStringToPref(
        Preferences.mobileNumber, controller.mobileNumber.value);
    _sfService.setStringToPref(Preferences.password, controller.password.value);
    _sfService.setStringToPref(Preferences.authToken, token);
  }
}
