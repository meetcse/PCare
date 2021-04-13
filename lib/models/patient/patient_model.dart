import 'package:pcare/models/user/user_model.dart';

class PatientModel {
  String id;
  List<OnGoingTreatmentId> ongoingTreatmentId;
  List<CompletedTreatmentId> completedTreatmentId;
  List<AppointmentId> appointmentId;
  String userId;
  UserModel user;

  PatientModel.fromMap(Map<String, dynamic> json) {
    id = json['_id'];
    user = UserModel.fromMap(json['user']);
    if (json['appointmentId'] != null) {
      List<dynamic> _appointments = json['appointmentId'];

      appointmentId = _appointments.map((e) {
        return AppointmentId.fromMap(e);
      }).toList();
    }
    if (json['user'] != null) {
      user = UserModel.fromMap(json['user']);
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
