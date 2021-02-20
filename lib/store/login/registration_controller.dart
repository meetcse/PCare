import 'package:get/get.dart';

class RegistrationController extends GetxController {
  var firstNameError = ''.obs;
  var lastNameError = ''.obs;
  var mobileNumberError = ''.obs;
  var passwordError = ''.obs;
  var reEnterPasswordError = ''.obs;
  var addressError = ''.obs;
  var genderError = ''.obs;
  var dobError = ''.obs;

  var firstName = ''.obs;
  var lastName = ''.obs;
  var mobileNumber = ''.obs;
  var password = ''.obs;
  var reEnterPassword = ''.obs;
  var address = ''.obs;
  var gender = ''.obs;
  var dob = ''.obs;
  var allow = true.obs;

  // bool get canForgetPassword => email.value.isNotEmpty;

  // void setEmail(String value) {
  //   email.value = value;
  //   // _setupValidations();
  //   validateEmail(email.value);
  // }

  bool validateForm() {
    if (firstName.value == "" ||
        lastName.value == "" ||
        mobileNumber.value == "" ||
        password.value == "" ||
        reEnterPassword.value == "" ||
        address.value == "" ||
        gender.value == "" ||
        dob.value == "" ||
        firstNameError.value != null ||
        lastNameError.value != null ||
        mobileNumberError.value != null ||
        passwordError.value != null ||
        reEnterPasswordError.value != null ||
        addressError.value != null ||
        genderError.value != null ||
        dobError.value != null) {
      return false;
    } else {
      return true;
    }
  }

  bool validateField(
    String value,
  ) {
    if (value.isEmpty) {
      return false;
    }
    return true;
  }

  void setAddress(String value) {
    address.value = value;
    if (!validateField(value)) {
      addressError.value = 'Address is required';
    } else {
      addressError.value = null;
    }
  }

  void setGender(String value) {
    gender.value = value;
    if (!validateField(value)) {
      genderError.value = 'Gender is required';
    } else {
      genderError.value = null;
    }
  }

  void setDob(String value) {
    dob.value = value;
    if (!validateField(value)) {
      dobError.value = 'DOB is required';
    } else {
      dobError.value = null;
    }
  }

  void setMobileNumber(String value) {
    mobileNumber.value = value;
    // _setupValidations();
    validateMobileNumber(mobileNumber.value);
  }

  void setFirstName(String value) {
    firstName.value = value;
    if (!validateField(value)) {
      firstNameError.value = 'First Name is required';
    } else {
      firstNameError.value = null;
    }
  }

  void setLastName(String value) {
    lastName.value = value;
    if (!validateField(value)) {
      lastNameError.value = 'Last Name is required';
    } else {
      lastNameError.value = null;
    }
  }

  void setReenterPassword(String value) {
    reEnterPassword.value = value;
    if (value.isEmpty) {
      reEnterPasswordError.value = "Re Enter Password can't be empty";
    } else if (value.length < 6) {
      reEnterPasswordError.value =
          "Re Enter Password must be at-least 6 char long";
    } else if (password.value != reEnterPassword.value) {
      reEnterPasswordError.value = "Password not matching";
    } else {
      reEnterPasswordError.value = null;
    }
  }

  void setPassword(String value) {
    password.value = value;
    // _setupValidations();
    validatePassword(password.value);
  }

  void validatePassword(String value) {
    if (value.isEmpty) {
      passwordError.value = "Password can't be empty";
    } else if (value.length < 6) {
      passwordError.value = "Password must be at-least 6 char long";
    } else {
      passwordError.value = null;
    }
  }

  // void setLoginWith(String value) {
  //   loginWith.value = value;
  // }

  // void validateEmail(String value) {
  //   bool validate = RegExp(
  //           r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
  //       .hasMatch(value);
  //   if (value.isEmpty) {
  //     emailError.value = "Email can't be empty";
  //     // errorMessage = emailError;
  //   } else if (!validate) {
  //     emailError.value = 'Please enter a valid Email Address';
  //   } else {
  //     emailError.value = null;
  //   }
  // }

  void validateMobileNumber(String value) {
    bool validate = RegExp(r'(^(?:[+0]9)?[0-9]{10,12}$)').hasMatch(value);
    if (value.isEmpty) {
      mobileNumberError.value = "Mobile Number can't be empty";
      // errorMessage = mobileNumberError;
    } else if (value.length != 10) {
      mobileNumberError.value = 'Please enter a 10 digit Mobile Number';
    } else if (!validate) {
      mobileNumberError.value = 'Please enter a valid Mobile Number';
    } else {
      mobileNumberError.value = null;
    }
  }

  // Future register() async {
  //   loading.value = true;
  // }

  // Future login() async {
  //   loading.value = true;

  //   Future.delayed(Duration(milliseconds: 2000)).then((future) {
  //     loading.value = false;
  //     success.value = true;
  //   }).catchError((e) {
  //     loading.value = false;
  //     success.value = false;
  //     // errorMessage = e.toString().contains("ERROR_USER_NOT_FOUND")
  //     //     ? "Email and password doesn't match"
  //     //     : "Something went wrong, please check your internet connection and try again";
  //     print(e);
  //   });
  // }

  // Future forgotPassword() async {
  //   loading.value = true;
  // }

  // Future logout() async {
  //   loading.value = true;
  // }

  // Future reset() async {
  //   email.value = '';
  //   password.value = '';
  //   emailError.value = null;
  //   passwordError.value = null;
  //   // errorMessage = '';
  //   success.value = false;
  //   loading.value = false;
  // }

  // void validateAll() {
  //   validatePassword(password.value);
  //   if (loginWith.value == 'email') {
  //     validateEmail(email.value);
  //   } else {
  //     validateMobileNumber(mobileNumber.value);
  //   }
  // }
}
