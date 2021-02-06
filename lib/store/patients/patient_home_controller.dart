import 'package:get/get.dart';
import 'package:pcare/constants/strings.dart';

class PatientHomeController extends GetxController {
  List<Map<String, dynamic>> drawerItems = [
    {
      "change": true,
      "id": UniversalStrings.home,
      "name": UniversalStrings.home,
      "navigateTo": '/home_page',
    },
    {
      "change": false,
      "id": UniversalStrings.bookAppointmentId,
      "name": UniversalStrings.bookAppointment,
      "navigateTo": '/search_doctor',
    },
    {
      "change": false,
      "id": UniversalStrings.myAppointmentsId,
      "name": UniversalStrings.myAppointments,
      "navigateTo": '/my_appointments',
    },
    {
      "change": false,
      "id": UniversalStrings.wishlistId,
      "name": UniversalStrings.wishlist,
      "navigateTo": '/wishlist',
    },
    {
      "change": false,
      "id": UniversalStrings.currentTreatmentId,
      "name": UniversalStrings.currentTreatment,
      "navigateTo": '/current_treatment',
    },
    {
      "change": true,
      "id": UniversalStrings.todosId,
      "name": UniversalStrings.todos,
      "navigateTo": '/patient_todos',
    },
    {
      "change": false,
      "id": UniversalStrings.recentReportsId,
      "name": UniversalStrings.recentReports,
      "navigateTo": '',
    },
    {
      "change": false,
      "id": UniversalStrings.policiesId,
      "name": UniversalStrings.policies,
      "navigateTo": '',
    },
    {
      "change": true,
      "id": UniversalStrings.aboutAppId,
      "name": UniversalStrings.aboutApp,
      "navigateTo": '',
    },
    {
      "change": false,
      "id": UniversalStrings.faqId,
      "name": UniversalStrings.faq,
      "navigateTo": '',
    },
    {
      "change": true,
      "id": UniversalStrings.myProfileId,
      "name": UniversalStrings.myProfile,
      "navigateTo": '',
    },
    {
      "change": false,
      "id": UniversalStrings.signOut,
      "name": UniversalStrings.signOut,
      "navigateTo": '',
    },
  ];

  var selected = UniversalStrings.home.obs;

  //actions -----------------------------------------------------

  void setSelectedItem(String value) {
    selected.value = value;
  }
}
