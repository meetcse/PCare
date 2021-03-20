class PatientModel {
  String id;
  List<OnGoingTreatmentId> ongoingTreatmentId;
  List<CompletedTreatmentId> completedTreatmentId;
  List<AppointmentId> appointmentId;

  String userId;

  PatientModel.fromMap(Map<String, dynamic> json) {
    id = json['_id'];
    if (json['appointmentId'] != null) {
      List<dynamic> _appointments = json['appointmentId'];

      appointmentId = _appointments.map((e) {
        return AppointmentId.fromMap(e);
      }).toList();
    }
  }

  //TODO: On going treatment id
  //TODO: completed treatment id
}

class AppointmentId {
  String id;
  String appointmentId;

  AppointmentId.fromMap(Map<String, dynamic> json) {
    id = json['_id'];
    appointmentId = json['appointment'];
  }
}

class OnGoingTreatmentId {}

class CompletedTreatmentId {}
