import 'package:mobx/mobx.dart';
part 'login_store.g.dart';

class LoginStore = _LoginStore with _$LoginStore;

abstract class _LoginStore with Store {
  _LoginStore() {
    _setupValidations();
  }

  // disposers:-----------------------------------------------------------------
  List<ReactionDisposer> _disposers;

  void _setupValidations() {
    _disposers = [
      reaction((_) => email, validateEmail),
      reaction((_) => password, validatePassword),
    ];
  }

  // store variables:-----------------------------------------------------------
  @observable
  String email = '';

  @observable
  String emailError = null;

  @observable
  String passwordError = null;

  @observable
  String errorMessage;

  @observable
  String password = '';

  @observable
  bool success = false;

  @observable
  bool loading = false;

  @observable
  bool isRemember = false;

  @computed
  bool get canLogin =>
      email.isNotEmpty &&
      password.isNotEmpty &&
      emailError == null &&
      passwordError == null &&
      errorMessage == null;

  @computed
  bool get canForgetPassword => email.isNotEmpty;

  // actions:-------------------------------------------------------------------
  @action
  void setEmail(String value) {
    email = value;
  }

  @action
  void setPassword(String value) {
    password = value;
  }

  @action
  void validateEmail(String value) {
    bool validate = RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(value);
    if (value.isEmpty) {
      emailError = "Email can't be empty";
      errorMessage = emailError;
    } else if (!validate) {
      emailError = 'Please enter a valid Email Address';
    } else {
      emailError = null;
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
      errorMessage = e.toString().contains("ERROR_USER_NOT_FOUND")
          ? "Email and password doesn't match"
          : "Something went wrong, please check your internet connection and try again";
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
    success = false;
    loading = false;
  }

  // general methods:-----------------------------------------------------------
  void dispose() {
    for (final d in _disposers) {
      d();
    }
  }

  void validateAll() {
    validatePassword(password);
    validateEmail(email);
  }
}
