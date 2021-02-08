import 'package:get/get.dart';
import 'package:intl/intl.dart';

class SearchDoctorController extends GetxController {
  var selectedDoctorId = ''.obs;
  var isSearching = false.obs;
  var searchResults = List<Map<String, dynamic>>().obs;

  void setIsSearching(bool value) {
    isSearching.value = value;
  }

  void setSelectedDoctorId(String id) {
    selectedDoctorId.value = id;
  }

  void searchDoctors(
      List<Map<String, dynamic>> doctorsList, String searchQuery) {
    searchResults.clear();

    doctorsList.forEach((doctor) {
      if (doctor['name']
          .toString()
          .toLowerCase()
          .contains(searchQuery.toLowerCase())) {
        searchResults.add(doctor);
      }
      if (!searchResults.contains(doctor) &&
          doctor['type']
              .toString()
              .toLowerCase()
              .contains(searchQuery.toLowerCase())) {
        searchResults.add(doctor);
      }
      if (!searchResults.contains(doctor) &&
          doctor['hospital']
              .toString()
              .toLowerCase()
              .contains(searchQuery.toLowerCase())) {
        searchResults.add(doctor);
      }
    });
  }

  //Ui controller methods
  List<int> getDoctorsCount(int totalItemLength) {
    List<int> _list = List.generate(totalItemLength, (i) => i);

    // shuffle it
    _list.shuffle();
    List<int> _getDisplayDoctors = List<int>();
    for (int i = 0; i < 4; i++) {
      _getDisplayDoctors.add(_list[i]);
    }
    return _getDisplayDoctors;
  }
}
