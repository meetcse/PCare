import 'package:get/get.dart';
import 'package:intl/intl.dart';

class SelectAppointmentDayController extends GetxController {
  var selectedDay = ''.obs;
  var isDatesLoaded = false.obs;

  void setDatesLoaded(bool value) {
    isDatesLoaded.value = value;
  }

  void setSelectedDay(String day) {
    selectedDay.value = day;
  }

  List<String> getDates(String workingDay) {
    List<String> _dates = List<String>();
    List<String> _workingDays = _getWorkingDayList(workingDay);

    for (int i = 0; i < 10; i++) {
      var _checkDate = DateTime.now().add(
        Duration(days: i),
      );

      String _checkDay = DateFormat('EEEE').format(_checkDate);
      if (_workingDays
          .toString()
          .toLowerCase()
          .contains(_checkDay.toLowerCase())) {
        String _displayDate =
            DateFormat('dd-MM').format(_checkDate) + ' (' + _checkDay + ')';

        _dates.add(_displayDate);
      }
    }
    return _dates;
  }

  List<String> _getWorkingDayList(String workingDay) {
    List<String> _splittedString;
    if (workingDay.contains('-')) {
      _splittedString = workingDay.split('-');
    } else {
      _splittedString = workingDay.split(',');
    }
    return _splittedString;
  }
}
