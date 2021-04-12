import 'package:pcare/models/doctor/DoctorModel.dart';
import 'package:pcare/models/patient/appointment/AppointmentModel.dart';
import 'package:pcare/models/patient/patient_model.dart';

class GetFullTreatmentModel {
  String id;
  PatientModel patientId;
  DoctorDetailsModel doctorId;
  List<Treatments> treatments;
  String status;
  String statusCompletedTime;
  String statusStartingDateTime;
  String createdDate;
  int iV;

  GetFullTreatmentModel(
      {this.id,
      this.patientId,
      this.doctorId,
      this.treatments,
      this.status,
      this.statusCompletedTime,
      this.statusStartingDateTime,
      this.createdDate,
      this.iV});

  GetFullTreatmentModel.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    patientId = json['patient_id'] != null
        ? new PatientModel.fromMap(json['patient_id'])
        : null;
    doctorId = json['doctor_id'] != null
        ? new DoctorDetailsModel.fromJson(json['doctor_id'])
        : null;
    if (json['treatments'] != null) {
      treatments = new List<Treatments>();
      json['treatments'].forEach((v) {
        treatments.add(new Treatments.fromJson(v));
      });
    }
    status = json['status'];
    statusCompletedTime = json['status_completed_time'];
    statusStartingDateTime = json['status_starting_date_time'];
    createdDate = json['created_date'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.id;
    if (this.patientId != null) {
      // data['patient_id'] = this.patientId.toJson();
    }
    if (this.doctorId != null) {
      data['doctor_id'] = this.doctorId.toJson();
    }
    if (this.treatments != null) {
      data['treatments'] = this.treatments.map((v) => v.toJson()).toList();
    }
    data['status'] = this.status;
    data['status_completed_time'] = this.statusCompletedTime;
    data['status_starting_date_time'] = this.statusStartingDateTime;
    data['created_date'] = this.createdDate;
    data['__v'] = this.iV;
    return data;
  }
}

class Treatments {
  String sId;
  String appointmentDate;
  AppointmentModel singleAppointmentId;
  SingleTreatmentId singleTreatmentId;

  Treatments(
      {this.sId,
      this.appointmentDate,
      this.singleAppointmentId,
      this.singleTreatmentId});

  Treatments.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    appointmentDate = json['appointment_date'];
    singleAppointmentId = json['single_appointment_id'] != null
        ? new AppointmentModel.fromJson(json['single_appointment_id'])
        : null;
    singleTreatmentId = json['single_treatment_id'] != null
        ? new SingleTreatmentId.fromJson(json['single_treatment_id'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['appointment_date'] = this.appointmentDate;
    if (this.singleAppointmentId != null) {
      data['single_appointment_id'] = this.singleAppointmentId.toJson();
    }
    if (this.singleTreatmentId != null) {
      data['single_treatment_id'] = this.singleTreatmentId.toJson();
    }
    return data;
  }
}

class SingleTreatmentId {
  String sId;
  String singleAppointmentId;
  String prescription;
  String disease;
  String specialNote;
  String experiments;
  String observation;
  String createddate;
  int iV;

  SingleTreatmentId(
      {this.sId,
      this.singleAppointmentId,
      this.prescription,
      this.disease,
      this.specialNote,
      this.experiments,
      this.observation,
      this.createddate,
      this.iV});

  SingleTreatmentId.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    singleAppointmentId = json['single_appointment_id'];
    prescription = json['prescription'];
    disease = json['disease'];
    specialNote = json['special_note'];
    experiments = json['experiments'];
    observation = json['observation'];
    createddate = json['createddate'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['single_appointment_id'] = this.singleAppointmentId;
    data['prescription'] = this.prescription;
    data['disease'] = this.disease;
    data['special_note'] = this.specialNote;
    data['experiments'] = this.experiments;
    data['observation'] = this.observation;
    data['createddate'] = this.createddate;
    data['__v'] = this.iV;
    return data;
  }
}
