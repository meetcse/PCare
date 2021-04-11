import 'package:pcare/models/user/user_model.dart';

class GetAllPatientsModel {
  String id;
  List<String> ongoingTreatmentId;
  List<CompletedTreatmentId> completedTreatmentId;
  List<AppointmentId> appointmentId = new List<AppointmentId>();
  UserModel user;

  GetAllPatientsModel.fromMap(Map<String, dynamic> json) {
    id = json['_id'];
    user = UserModel.fromMap(json['user']);
    ongoingTreatmentId = json['ongoing_treatment_id'].cast<String>();
    if (json['appointment_id'] != null) {
      json['appointment_id'].forEach((v) {
        appointmentId.add(new AppointmentId.fromJson(v));
      });
    }
  }
}

class AppointmentId {
  String sId;
  Appointment appointment;

  AppointmentId({this.sId, this.appointment});

  AppointmentId.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    appointment = json['appointment'] != null
        ? new Appointment.fromJson(json['appointment'])
        : null;
  }
}

class Appointment {
  String status;
  String sId;
  String patientId;
  String doctorId;
  String appointmentTime;
  String appointmentDate;
  String fullTreatmentId;
  String singleTreatmentId;

  Appointment.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    sId = json['_id'];
    patientId = json['patient_id'];
    doctorId = json['doctor_id'];
    appointmentTime = json['appointment_time'];
    appointmentDate = json['appointment_date'];
    fullTreatmentId = json['full_treatment_id'];
    singleTreatmentId = json['single_treatment_id'];
  }
}

class CompletedTreatmentId {}
