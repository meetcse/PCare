import 'package:get/get.dart';

class SelectAppointmentTimeController extends GetxController {
  var selectedTime = ''.obs;
  var isTimeLoaded = true.obs;

  void setTimeLoaded(bool value) {
    isTimeLoaded.value = value;
  }

  void setSelectedTime(String day) {
    selectedTime.value = day;
  }
}
