import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:pcare/models/patient/appointment/SearchDoctorInPatientModel.dart';

class SearchDoctorController extends GetxController {
  var selectedDoctorId = ''.obs;
  var isSearching = false.obs;
  var searchResults = <SearchDoctorsInPatientModel>[].obs;
  var allow = true.obs;

  void setIsSearching(bool value) {
    isSearching.value = value;
  }

  void setSelectedDoctorId(String id) {
    selectedDoctorId.value = id;
  }

  void searchDoctors(
      List<SearchDoctorsInPatientModel> doctorsList, String searchQuery) {
    searchResults.clear();

    doctorsList.forEach((doctor) {
      if (doctor.user.firstName
              .toString()
              .toLowerCase()
              .contains(searchQuery.toLowerCase()) ||
          doctor.user.lastName
              .toString()
              .toLowerCase()
              .contains(searchQuery.toLowerCase())) {
        searchResults.add(doctor);
      }
      if (!searchResults.contains(doctor) &&
          doctor.doctorType
              .toString()
              .toLowerCase()
              .contains(searchQuery.toLowerCase())) {
        searchResults.add(doctor);
      }
      if (!searchResults.contains(doctor) &&
              doctor.hospitalId.hospitalName
                  .toString()
                  .toLowerCase()
                  .contains(searchQuery.toLowerCase()) ||
          doctor.hospitalId.hospitalAddress
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
