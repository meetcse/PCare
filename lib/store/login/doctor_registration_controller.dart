import 'package:get/get.dart';

class DoctorRegistrationController extends GetxController {
  var mciId = ''.obs;
  var hospitalName = ''.obs;
  var hospitalAddress = ''.obs;
  var doctorType = ''.obs;
  var allow = true.obs;

  var mciIdErrorText = ''.obs;

  bool isAnyFieldEmpty() {
    if (mciId.value == "" ||
        hospitalName.value == "" ||
        hospitalAddress.value == "" ||
        doctorType.value == "" ||
        mciIdErrorText.value != "") {
      return true;
    } else {
      return false;
    }
  }

  void setmciid(String value) {
    mciId.value = value;
    if (value.length < 6) {
      mciIdErrorText.value = "It should be minimum 6 characters";
    } else {
      mciIdErrorText.value = "";
    }
  }

  void sethospitalName(String value) {
    hospitalName.value = value;
  }

  void sethospitalAddress(String value) {
    hospitalAddress.value = value;
  }

  void setdoctorType(String value) {
    doctorType.value = value;
  }
}
