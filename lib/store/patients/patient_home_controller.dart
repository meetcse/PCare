import 'package:get/get.dart';
import 'package:pcare/constants/strings.dart';
import 'package:pcare/ui/patient/HomePage.dart';
import 'package:pcare/ui/patient/appointments/my_appointments.dart';
import 'package:pcare/ui/patient/appointments/search_doctor.dart';
import 'package:pcare/ui/patient/patient_todos.dart';
import 'package:pcare/ui/patient/view_appointments/view_single_appointment.dart';
import 'package:pcare/ui/patient/wishlist.dart';

class PatientHomeController extends GetxController {
  List<Map<String, dynamic>> drawerItems = [
    {
      "change": true,
      "id": UniversalStrings.home,
      "name": UniversalStrings.home,
      "navigateTo": HomePage(),
    },
    {
      "change": false,
      "id": UniversalStrings.bookAppointmentId,
      "name": UniversalStrings.bookAppointment,
      "navigateTo": SearchDoctor(),
    },
    {
      "change": false,
      "id": UniversalStrings.myAppointmentsId,
      "name": UniversalStrings.myAppointments,
      "navigateTo": MyAppointments(),
    },
    // {
    //   "change": false,
    //   "id": UniversalStrings.wishlistId,
    //   "name": UniversalStrings.wishlist,
    //   "navigateTo": Wishlist(),
    // },
    {
      "change": false,
      "id": UniversalStrings.currentTreatmentId,
      "name": UniversalStrings.currentTreatment,
      "navigateTo": ViewSingleAppointment(),
    },
    // {
    //   "change": true,
    //   "id": UniversalStrings.todosId,
    //   "name": UniversalStrings.todos,
    //   "navigateTo": PatientTodos(),
    // },
    // {
    //   "change": false,
    //   "id": UniversalStrings.recentReportsId,
    //   "name": UniversalStrings.recentReports,
    //   "navigateTo": '',
    // },
    // {
    //   "change": false,
    //   "id": UniversalStrings.policiesId,
    //   "name": UniversalStrings.policies,
    //   "navigateTo": '',
    // },
    // {
    //   "change": true,
    //   "id": UniversalStrings.aboutAppId,
    //   "name": UniversalStrings.aboutApp,
    //   "navigateTo": '',
    // },
    // {
    //   "change": false,
    //   "id": UniversalStrings.faqId,
    //   "name": UniversalStrings.faq,
    //   "navigateTo": '',
    // },
    // {
    //   "change": true,
    //   "id": UniversalStrings.myProfileId,
    //   "name": UniversalStrings.myProfile,
    //   "navigateTo": '',
    // },
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
