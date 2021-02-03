import 'package:mobx/mobx.dart';
import 'package:pcare/constants/strings.dart';
part 'patient_home_store.g.dart';

class PatientHomeStore = _PatientHomeStore with _$PatientHomeStore;

abstract class _PatientHomeStore with Store {
  _PatientHomeStore() {}

  List<Map<String, dynamic>> drawerItems = [
    {
      "change": true,
      "id": UniversalStrings.home,
      "name": UniversalStrings.home,
    },
    {
      "change": false,
      "id": UniversalStrings.bookAppointmentId,
      "name": UniversalStrings.bookAppointment,
    },
    {
      "change": false,
      "id": UniversalStrings.myAppointmentsId,
      "name": UniversalStrings.myAppointments,
    },
    {
      "change": false,
      "id": UniversalStrings.wishlistId,
      "name": UniversalStrings.wishlist,
    },
    {
      "change": false,
      "id": UniversalStrings.currentTreatmentId,
      "name": UniversalStrings.currentTreatment,
    },
    {
      "change": true,
      "id": UniversalStrings.todosId,
      "name": UniversalStrings.todos,
    },
    {
      "change": false,
      "id": UniversalStrings.recentReportsId,
      "name": UniversalStrings.recentReports,
    },
    {
      "change": false,
      "id": UniversalStrings.policiesId,
      "name": UniversalStrings.policies,
    },
    {
      "change": true,
      "id": UniversalStrings.aboutAppId,
      "name": UniversalStrings.aboutApp,
    },
    {
      "change": false,
      "id": UniversalStrings.faqId,
      "name": UniversalStrings.faq,
    },
    {
      "change": true,
      "id": UniversalStrings.myProfileId,
      "name": UniversalStrings.myProfile,
    },
    {
      "change": false,
      "id": UniversalStrings.signOut,
      "name": UniversalStrings.signOut,
    },
  ];

  //observables ----------------------------------------------

  @observable
  String selected = UniversalStrings.home;

  //actions -----------------------------------------------------
  @action
  void setSelectedItem(String value) {
    selected = value;
  }
}
