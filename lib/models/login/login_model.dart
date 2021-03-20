import 'package:pcare/models/patient/patient_model.dart';
import 'package:pcare/models/user/user_model.dart';

class LoginModel {
  bool success;
  String token;
  UserModel user;
  PatientModel patientModel;
  Map<String, dynamic> doctorModel;
  Map<String, dynamic> receptionistModel;

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
  }
}
