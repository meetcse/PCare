// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$LoginStore on _LoginStore, Store {
  Computed<bool> _$canLoginComputed;

  @override
  bool get canLogin => (_$canLoginComputed ??=
          Computed<bool>(() => super.canLogin, name: '_LoginStore.canLogin'))
      .value;
  Computed<bool> _$canForgetPasswordComputed;

  @override
  bool get canForgetPassword => (_$canForgetPasswordComputed ??= Computed<bool>(
          () => super.canForgetPassword,
          name: '_LoginStore.canForgetPassword'))
      .value;

  final _$emailAtom = Atom(name: '_LoginStore.email');

  @override
  String get email {
    _$emailAtom.reportRead();
    return super.email;
  }

  @override
  set email(String value) {
    _$emailAtom.reportWrite(value, super.email, () {
      super.email = value;
    });
  }

  final _$mobileNumberAtom = Atom(name: '_LoginStore.mobileNumber');

  @override
  String get mobileNumber {
    _$mobileNumberAtom.reportRead();
    return super.mobileNumber;
  }

  @override
  set mobileNumber(String value) {
    _$mobileNumberAtom.reportWrite(value, super.mobileNumber, () {
      super.mobileNumber = value;
    });
  }

  final _$emailErrorAtom = Atom(name: '_LoginStore.emailError');

  @override
  String get emailError {
    _$emailErrorAtom.reportRead();
    return super.emailError;
  }

  @override
  set emailError(String value) {
    _$emailErrorAtom.reportWrite(value, super.emailError, () {
      super.emailError = value;
    });
  }

  final _$mobileNumberErrorAtom = Atom(name: '_LoginStore.mobileNumberError');

  @override
  String get mobileNumberError {
    _$mobileNumberErrorAtom.reportRead();
    return super.mobileNumberError;
  }

  @override
  set mobileNumberError(String value) {
    _$mobileNumberErrorAtom.reportWrite(value, super.mobileNumberError, () {
      super.mobileNumberError = value;
    });
  }

  final _$passwordErrorAtom = Atom(name: '_LoginStore.passwordError');

  @override
  String get passwordError {
    _$passwordErrorAtom.reportRead();
    return super.passwordError;
  }

  @override
  set passwordError(String value) {
    _$passwordErrorAtom.reportWrite(value, super.passwordError, () {
      super.passwordError = value;
    });
  }

  final _$loginWithAtom = Atom(name: '_LoginStore.loginWith');

  @override
  String get loginWith {
    _$loginWithAtom.reportRead();
    return super.loginWith;
  }

  @override
  set loginWith(String value) {
    _$loginWithAtom.reportWrite(value, super.loginWith, () {
      super.loginWith = value;
    });
  }

  final _$passwordAtom = Atom(name: '_LoginStore.password');

  @override
  String get password {
    _$passwordAtom.reportRead();
    return super.password;
  }

  @override
  set password(String value) {
    _$passwordAtom.reportWrite(value, super.password, () {
      super.password = value;
    });
  }

  final _$successAtom = Atom(name: '_LoginStore.success');

  @override
  bool get success {
    _$successAtom.reportRead();
    return super.success;
  }

  @override
  set success(bool value) {
    _$successAtom.reportWrite(value, super.success, () {
      super.success = value;
    });
  }

  final _$loadingAtom = Atom(name: '_LoginStore.loading');

  @override
  bool get loading {
    _$loadingAtom.reportRead();
    return super.loading;
  }

  @override
  set loading(bool value) {
    _$loadingAtom.reportWrite(value, super.loading, () {
      super.loading = value;
    });
  }

  final _$isRememberAtom = Atom(name: '_LoginStore.isRemember');

  @override
  bool get isRemember {
    _$isRememberAtom.reportRead();
    return super.isRemember;
  }

  @override
  set isRemember(bool value) {
    _$isRememberAtom.reportWrite(value, super.isRemember, () {
      super.isRemember = value;
    });
  }

  final _$registerAsyncAction = AsyncAction('_LoginStore.register');

  @override
  Future<dynamic> register() {
    return _$registerAsyncAction.run(() => super.register());
  }

  final _$loginAsyncAction = AsyncAction('_LoginStore.login');

  @override
  Future<dynamic> login() {
    return _$loginAsyncAction.run(() => super.login());
  }

  final _$forgotPasswordAsyncAction = AsyncAction('_LoginStore.forgotPassword');

  @override
  Future<dynamic> forgotPassword() {
    return _$forgotPasswordAsyncAction.run(() => super.forgotPassword());
  }

  final _$logoutAsyncAction = AsyncAction('_LoginStore.logout');

  @override
  Future<dynamic> logout() {
    return _$logoutAsyncAction.run(() => super.logout());
  }

  final _$resetAsyncAction = AsyncAction('_LoginStore.reset');

  @override
  Future<dynamic> reset() {
    return _$resetAsyncAction.run(() => super.reset());
  }

  final _$_LoginStoreActionController = ActionController(name: '_LoginStore');

  @override
  void setEmail(String value) {
    final _$actionInfo =
        _$_LoginStoreActionController.startAction(name: '_LoginStore.setEmail');
    try {
      return super.setEmail(value);
    } finally {
      _$_LoginStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setMobileNumber(String value) {
    final _$actionInfo = _$_LoginStoreActionController.startAction(
        name: '_LoginStore.setMobileNumber');
    try {
      return super.setMobileNumber(value);
    } finally {
      _$_LoginStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setPassword(String value) {
    final _$actionInfo = _$_LoginStoreActionController.startAction(
        name: '_LoginStore.setPassword');
    try {
      return super.setPassword(value);
    } finally {
      _$_LoginStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setLoginWith(String value) {
    final _$actionInfo = _$_LoginStoreActionController.startAction(
        name: '_LoginStore.setLoginWith');
    try {
      return super.setLoginWith(value);
    } finally {
      _$_LoginStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void validateEmail(String value) {
    final _$actionInfo = _$_LoginStoreActionController.startAction(
        name: '_LoginStore.validateEmail');
    try {
      return super.validateEmail(value);
    } finally {
      _$_LoginStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void validateMobileNumber(String value) {
    final _$actionInfo = _$_LoginStoreActionController.startAction(
        name: '_LoginStore.validateMobileNumber');
    try {
      return super.validateMobileNumber(value);
    } finally {
      _$_LoginStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void validatePassword(String value) {
    final _$actionInfo = _$_LoginStoreActionController.startAction(
        name: '_LoginStore.validatePassword');
    try {
      return super.validatePassword(value);
    } finally {
      _$_LoginStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
email: ${email},
mobileNumber: ${mobileNumber},
emailError: ${emailError},
mobileNumberError: ${mobileNumberError},
passwordError: ${passwordError},
loginWith: ${loginWith},
password: ${password},
success: ${success},
loading: ${loading},
isRemember: ${isRemember},
canLogin: ${canLogin},
canForgetPassword: ${canForgetPassword}
    ''';
  }
}
