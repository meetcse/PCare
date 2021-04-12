import 'package:pcare/models/doctor/DoctorModel.dart';
import 'package:pcare/models/patient/patient_model.dart';

class AppointmentModel {
  String status;
  String sId;
  PatientModel patientId;
  DoctorDetailsModel doctorId;
  String appointmentTime;
  String appointmentDate;
  String createddate;
  String full_treatment_id;
  String single_treatment_id;
  int iV;

  AppointmentModel(
      {this.status,
      this.sId,
      this.patientId,
      this.doctorId,
      this.appointmentTime,
      this.appointmentDate,
      this.createddate,
      this.full_treatment_id,
      this.single_treatment_id,
      this.iV});

  AppointmentModel.fromJson(Map<String, dynamic> json) {
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
    if (json['single_treatment_id'] != null) {
      single_treatment_id = json['single_treatment_id'];
    }
    if (json['full_treatment_id'] != null) {
      full_treatment_id = json['full_treatment_id'];
    }
    createddate = json['createddate'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['_id'] = this.sId;
    if (this.patientId != null) {
      // data['patient_id'] = this.patientId.();
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
