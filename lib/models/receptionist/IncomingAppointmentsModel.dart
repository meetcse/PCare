import 'package:pcare/models/doctor/DoctorModel.dart';
import 'package:pcare/models/patient/patient_model.dart';

class IncomingAppointmentModel {
  List<NewAppointment> newAppointment;

  IncomingAppointmentModel({this.newAppointment});

  IncomingAppointmentModel.fromJson(Map<String, dynamic> json) {
    if (json['newAppointment'] != null) {
      newAppointment = [];
      json['newAppointment'].forEach((v) {
        newAppointment.add(new NewAppointment.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.newAppointment != null) {
      data['newAppointment'] =
          this.newAppointment.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class NewAppointment {
  String status;
  String sId;
  PatientModel patientId;
  DoctorDetailsModel doctorId;
  String appointmentTime;
  String appointmentDate;
  String createddate;
  int iV;

  NewAppointment(
      {this.status,
      this.sId,
      this.patientId,
      this.doctorId,
      this.appointmentTime,
      this.appointmentDate,
      this.createddate,
      this.iV});

  NewAppointment.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    sId = json['_id'];
    patientId = json['patient_id'] != null
        ? new PatientModel.fromMap(json['patient_id'])
        : null;
    doctorId = json['doctor_id'] != null
        ? new DoctorDetailsModel.fromJson(json['doctor_id'])
        : null;
    appointmentTime = json['appointment_time'];
    appointmentDate = json['appointment_date'];
    createddate = json['createddate'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['_id'] = this.sId;
    if (this.patientId != null) {
      // data['patient_id'] = this.patientId.toJson();
    }
    if (this.doctorId != null) {
      data['doctor_id'] = this.doctorId.toJson();
    }
    data['appointment_time'] = this.appointmentTime;
    data['appointment_date'] = this.appointmentDate;
    data['createddate'] = this.createddate;
    data['__v'] = this.iV;
    return data;
  }
}
