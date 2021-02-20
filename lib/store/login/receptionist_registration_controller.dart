import 'package:get/get.dart';

class ReceptionistRegistrationController extends GetxController {
  var doctorName = ''.obs;
  var hospitalName = ''.obs;
  var allow = true.obs;

  void setdoctorName(String value) {
    doctorName.value = value;
  }

  void sethospitalName(String value) {
    hospitalName.value = value;
  }
}
