import 'package:pcare/models/doctor/DoctorModel.dart';
import 'package:pcare/models/patient/patient_model.dart';
import 'package:pcare/models/receptionist/ReceptionistModel.dart';
import 'package:pcare/models/user/user_model.dart';

class LoginModel {
  bool success;
  String token;
  UserModel user;
  PatientModel patientModel;
  DoctorDetailsModel doctorDetails;
  ReceptionistModel receptionistDetails;

  LoginModel({
    this.success,
    this.token,
    this.user,
    this.patientModel,
    this.doctorDetails,
    this.receptionistDetails,
  });

  LoginModel.fromMap(Map<String, dynamic> json) {
    success = json['success'];
    token = json['token'];
    if (json['user'] != null) {
      Map<String, dynamic> _user = json['user'];
      user = UserModel.fromMap(_user);
    }

    if (user.userType.toLowerCase() == "patient") {
      Map<String, dynamic> _user = json['patient_details'];
      patientModel = PatientModel.fromMap(_user);
    }

    if (user.userType.toLowerCase() == "doctor") {
      doctorDetails = json['doctor_details'] != null
          ? new DoctorDetailsModel.fromJson(json['doctor_details'])
          : null;
    }

    if (user.userType.toLowerCase() == "receptionist") {
      receptionistDetails = json['receptionist_details'] != null
          ? new ReceptionistModel.fromJson(json['receptionist_details'])
          : null;
    }
  }
}
