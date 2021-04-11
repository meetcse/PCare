import 'package:pcare/models/receptionist/ReceptionistModel.dart';
import 'package:pcare/models/signup/HospitalModel.dart';
import 'package:pcare/models/user/user_model.dart';

class SearchDoctorsInPatientModel {
  List<String> workingDays;
  List<String> workingHours;
  List<String> treatmentId;
  String id;
  UserModel user;
  String mciId;
  bool specialist;
  String specialistIn;
  String doctorType;
  HospitalModel hospitalId;
  int approxAppointPerSlot;
  int iV;
  ReceptionistModel receptionistId;

  SearchDoctorsInPatientModel(
      {this.workingDays,
      this.workingHours,
      this.treatmentId,
      this.id,
      this.user,
      this.mciId,
      this.specialist,
      this.specialistIn,
      this.doctorType,
      this.hospitalId,
      this.approxAppointPerSlot,
      this.iV,
      this.receptionistId});

  SearchDoctorsInPatientModel.fromJson(Map<String, dynamic> json) {
    workingDays = json['working_days'].cast<String>();
    workingHours = json['working_hours'].cast<String>();
    if (json['treatment_id'] != null) {
      treatmentId = [];
      json['treatment_id'].forEach((v) {
        treatmentId.add(v);
      });
    }
    id = json['_id'] ?? '';
    user = json['user'] != null ? new UserModel.fromMap(json['user']) : null;
    mciId = json['mci_id'] ?? '';
    specialist = json['specialist'] ?? false;
    specialistIn = json['specialist_in'] ?? '';
    doctorType = json['doctor_type'] ?? '';
    hospitalId = json['hospital_id'] != null
        ? new HospitalModel.fromJson(json['hospital_id'])
        : null;
    approxAppointPerSlot = json['approx_appoint_per_slot'] ?? 0;
    iV = json['__v'];
    receptionistId = json['receptionist_id'] != null
        ? new ReceptionistModel.fromJson(json['receptionist_id'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['working_days'] = this.workingDays;
    data['working_hours'] = this.workingHours;
    if (this.treatmentId != null) {
      data['treatment_id'] = this.treatmentId.map((v) => v).toList();
    }
    data['_id'] = this.id;
    // if (this.user != null) {
    //   data['user'] = this.user.;
    // }
    data['mci_id'] = this.mciId;
    data['specialist'] = this.specialist;
    data['specialist_in'] = this.specialistIn;
    data['doctor_type'] = this.doctorType;
    data['hospital_id'] = this.hospitalId;
    data['approx_appoint_per_slot'] = this.approxAppointPerSlot;
    data['__v'] = this.iV;
    data['receptionist_id'] = this.receptionistId;
    return data;
  }
}
