import 'package:mobx/mobx.dart';
part 'login_store.g.dart';

class LoginStore = _LoginStore with _$LoginStore;

abstract class _LoginStore with Store {
  _LoginStore() {
    // _setupValidations();
  }

  // disposers:-----------------------------------------------------------------
  List<ReactionDisposer> _disposers;

  void _setupValidations() {
    _disposers = [
      reaction((_) => email, validateEmail),
      reaction((_) => password, validatePassword),
      reaction((_) => mobileNumber, validateMobileNumber),
    ];
  }

  // store variables:-----------------------------------------------------------
  @observable
  String email = '';

  @observable
  String mobileNumber = '';

  @observable
  String emailError = null;

  @observable
  String mobileNumberError = null;

  @observable
  String passwordError = null;

  @observable
  String loginWith = 'email';

  @observable
  String password = '';

  @observable
  bool success = false;

  @observable
  bool loading = false;

  @observable
  bool isRemember = false;

  @computed
  bool get canLogin => loginWith == 'email'
      ? email.isNotEmpty &&
          password.isNotEmpty &&
          emailError == null &&
          passwordError == null
      : mobileNumber.isNotEmpty &&
          mobileNumberError == null &&
          password.isNotEmpty &&
          passwordError == null;

  @computed
  bool get canForgetPassword => email.isNotEmpty;

  // actions:-------------------------------------------------------------------
  @action
  void setEmail(String value) {
    email = value;
    // _setupValidations();
    validateEmail(email);
  }

  @action
  void setMobileNumber(String value) {
    mobileNumber = value;
    // _setupValidations();
    validateMobileNumber(mobileNumber);
  }

  @action
  void setPassword(String value) {
    password = value;
    // _setupValidations();
    validatePassword(password);
  }

  @action
  void setLoginWith(String value) {
    loginWith = value;
  }

  @action
  void validateEmail(String value) {
    bool validate = RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(value);
    if (value.isEmpty) {
      emailError = "Email can't be empty";
      // errorMessage = emailError;
    } else if (!validate) {
      emailError = 'Please enter a valid Email Address';
    } else {
      emailError = null;
      errorMessage = null;
    }
  }

  @action
  void validateMobileNumber(String value) {
    bool validate = RegExp(r'(^(?:[+0]9)?[0-9]{10,12}$)').hasMatch(value);
    if (value.isEmpty) {
      mobileNumberError = "Mobile Number can't be empty";
      // errorMessage = mobileNumberError;
    } else if (!validate) {
      mobileNumberError = 'Please enter a valid Mobile Number';
    } else {
      mobileNumberError = null;
      errorMessage = null;
    }
  }

  @action
  void validatePassword(String value) {
    if (value.isEmpty) {
      passwordError = "Password can't be empty";
    } else if (value.length < 6) {
      passwordError = "Password must be at-least 6 char long";
    } else {
      passwordError = null;
      errorMessage = null;
    }
  }

  @action
  Future register() async {
    loading = true;
  }

  @action
  Future login() async {
    loading = true;

    Future.delayed(Duration(milliseconds: 2000)).then((future) {
      loading = false;
      success = true;
    }).catchError((e) {
      loading = false;
      success = false;
      // errorMessage = e.toString().contains("ERROR_USER_NOT_FOUND")
      //     ? "Email and password doesn't match"
      //     : "Something went wrong, please check your internet connection and try again";
      print(e);
    });
  }

  @action
  Future forgotPassword() async {
    loading = true;
  }

  @action
  Future logout() async {
    loading = true;
  }

  @action
  Future reset() async {
    email = '';
    password = '';
    emailError = null;
    passwordError = null;
    // errorMessage = '';
    success = false;
    loading = false;
  }

  // general methods:-----------------------------------------------------------
  void dispose() {
    // for (final d in _disposers) {
    //   d();
    // }
  }

  void validateAll() {
    validatePassword(password);
    if (loginWith == 'email') {
      validateEmail(email);
    } else {
      validateMobileNumber(mobileNumber);
    }
  }
}
