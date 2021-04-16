import 'package:pcare/models/doctor/DoctorModel.dart';
import 'package:pcare/models/patient/patient_model.dart';

class FullTreatmentModel {
  List<Treatments> treatments;

  FullTreatmentModel({this.treatments});

  FullTreatmentModel.fromJson(Map<String, dynamic> json) {
    if (json['treatments'] != null) {
      treatments = new List<Treatments>();
      json['treatments'].forEach((v) {
        treatments.add(new Treatments.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.treatments != null) {
      data['treatments'] = this.treatments.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Treatments {
  String sId;
  String appointmentDate;
  SingleAppointmentId singleAppointmentId;
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
        ? new SingleAppointmentId.fromJson(json['single_appointment_id'])
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

class SingleAppointmentId {
  String status;
  String sId;
  PatientModel patientId;
  DoctorDetailsModel doctorId;
  String appointmentTime;
  String appointmentDate;
  String createddate;
  int iV;
  String fullTreatmentId;
  String singleTreatmentId;

  SingleAppointmentId(
      {this.status,
      this.sId,
      this.patientId,
      this.doctorId,
      this.appointmentTime,
      this.appointmentDate,
      this.createddate,
      this.iV,
      this.fullTreatmentId,
      this.singleTreatmentId});

  SingleAppointmentId.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    sId = json['_id'];
    patientId = PatientModel.fromMap(json['patient_id']);
    doctorId = DoctorDetailsModel.fromJson(json['doctor_id']);
    appointmentTime = json['appointment_time'];
    appointmentDate = json['appointment_date'];
    createddate = json['createddate'];
    iV = json['__v'];
    fullTreatmentId = json['full_treatment_id'];
    singleTreatmentId = json['single_treatment_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['_id'] = this.sId;
    data['patient_id'] = this.patientId;
    data['doctor_id'] = this.doctorId;
    data['appointment_time'] = this.appointmentTime;
    data['appointment_date'] = this.appointmentDate;
    data['createddate'] = this.createddate;
    data['__v'] = this.iV;
    data['full_treatment_id'] = this.fullTreatmentId;
    data['single_treatment_id'] = this.singleTreatmentId;
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
