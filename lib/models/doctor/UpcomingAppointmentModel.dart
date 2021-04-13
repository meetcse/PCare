import 'package:pcare/models/doctor/DoctorModel.dart';
import 'package:pcare/models/patient/patient_model.dart';

class UpcomingAppointmentModel {
  String status;
  String id;
  PatientModel patient_id;
  DoctorDetailsModel doctor_id;
  String appointment_time;
  String appointment_date;

  UpcomingAppointmentModel({
    this.status,
    this.id,
    this.patient_id,
    this.doctor_id,
    this.appointment_time,
    this.appointment_date,
  });

  factory UpcomingAppointmentModel.fromMap(Map<String, dynamic> map) {
    return UpcomingAppointmentModel(
      status: map['status'],
      id: map['id'],
      patient_id: PatientModel.fromMap(map['patient_id']),
      appointment_time: map['appointment_time'],
      appointment_date: map['appointment_date'],
    );
  }
}
