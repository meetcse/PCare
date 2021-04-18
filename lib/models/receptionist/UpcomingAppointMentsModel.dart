class ReceptionistUpcomingAppointmentModel {
  String appointmentDate;
  List<Appointments> appointments;

  ReceptionistUpcomingAppointmentModel(
      {this.appointmentDate, this.appointments});

  ReceptionistUpcomingAppointmentModel.fromJson(Map<String, dynamic> json) {
    appointmentDate = json['appointment_date'];
    if (json['appointments'] != null) {
      appointments = new List<Appointments>();
      json['appointments'].forEach((v) {
        appointments.add(new Appointments.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['appointment_date'] = this.appointmentDate;
    if (this.appointments != null) {
      data['appointments'] = this.appointments.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Appointments {
  String status;
  String sId;
  PatientId patientId;
  DoctorId doctorId;
  String appointmentTime;
  String appointmentDate;
  String createddate;
  int iV;

  Appointments(
      {this.status,
      this.sId,
      this.patientId,
      this.doctorId,
      this.appointmentTime,
      this.appointmentDate,
      this.createddate,
      this.iV});

  Appointments.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    sId = json['_id'];
    patientId = json['patient_id'] != null
        ? new PatientId.fromJson(json['patient_id'])
        : null;
    doctorId = json['doctor_id'] != null
        ? new DoctorId.fromJson(json['doctor_id'])
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
      data['patient_id'] = this.patientId.toJson();
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

class PatientId {
  List<String> ongoingTreatmentId;
  String sId;
  User user;
  List<AppointmentId> appointmentId;
  int iV;

  PatientId(
      {this.ongoingTreatmentId,
      this.sId,
      this.user,
      this.appointmentId,
      this.iV});

  PatientId.fromJson(Map<String, dynamic> json) {
    ongoingTreatmentId = json['ongoing_treatment_id'].cast<String>();
    sId = json['_id'];
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
    if (json['appointment_id'] != null) {
      appointmentId = new List<AppointmentId>();
      json['appointment_id'].forEach((v) {
        appointmentId.add(new AppointmentId.fromJson(v));
      });
    }
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ongoing_treatment_id'] = this.ongoingTreatmentId;
    data['_id'] = this.sId;
    if (this.user != null) {
      data['user'] = this.user.toJson();
    }
    if (this.appointmentId != null) {
      data['appointment_id'] =
          this.appointmentId.map((v) => v.toJson()).toList();
    }
    data['__v'] = this.iV;
    return data;
  }
}

class User {
  Address address;
  String sId;
  String firstname;
  String lastname;
  String mobilenumber;
  String password;
  String gender;
  String dob;
  String age;
  String usertype;
  String createddate;
  String profilepic;
  int iV;

  User(
      {this.address,
      this.sId,
      this.firstname,
      this.lastname,
      this.mobilenumber,
      this.password,
      this.gender,
      this.dob,
      this.age,
      this.usertype,
      this.createddate,
      this.profilepic,
      this.iV});

  User.fromJson(Map<String, dynamic> json) {
    address =
        json['address'] != null ? new Address.fromJson(json['address']) : null;
    sId = json['_id'];
    firstname = json['firstname'];
    lastname = json['lastname'];
    mobilenumber = json['mobilenumber'];
    password = json['password'];
    gender = json['gender'];
    dob = json['dob'];
    age = json['age'];
    usertype = json['usertype'];
    createddate = json['createddate'];
    profilepic = json['profilepic'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.address != null) {
      data['address'] = this.address.toJson();
    }
    data['_id'] = this.sId;
    data['firstname'] = this.firstname;
    data['lastname'] = this.lastname;
    data['mobilenumber'] = this.mobilenumber;
    data['password'] = this.password;
    data['gender'] = this.gender;
    data['dob'] = this.dob;
    data['age'] = this.age;
    data['usertype'] = this.usertype;
    data['createddate'] = this.createddate;
    data['profilepic'] = this.profilepic;
    data['__v'] = this.iV;
    return data;
  }
}

class Address {
  String country;
  String houseno;
  String society;
  String area;
  String city;
  String state;

  Address(
      {this.country,
      this.houseno,
      this.society,
      this.area,
      this.city,
      this.state});

  Address.fromJson(Map<String, dynamic> json) {
    country = json['country'];
    houseno = json['houseno'];
    society = json['society'];
    area = json['area'];
    city = json['city'];
    state = json['state'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['country'] = this.country;
    data['houseno'] = this.houseno;
    data['society'] = this.society;
    data['area'] = this.area;
    data['city'] = this.city;
    data['state'] = this.state;
    return data;
  }
}

class AppointmentId {
  String sId;
  String appointment;

  AppointmentId({this.sId, this.appointment});

  AppointmentId.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    appointment = json['appointment'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['appointment'] = this.appointment;
    return data;
  }
}

class DoctorId {
  List<String> workingDays;
  List<String> workingHours;
  List<String> treatmentId;
  String sId;
  User user;
  String mciId;
  bool specialist;
  String specialistIn;
  String doctorType;
  String hospitalId;
  int approxAppointPerSlot;
  int iV;

  DoctorId(
      {this.workingDays,
      this.workingHours,
      this.treatmentId,
      this.sId,
      this.user,
      this.mciId,
      this.specialist,
      this.specialistIn,
      this.doctorType,
      this.hospitalId,
      this.approxAppointPerSlot,
      this.iV});

  DoctorId.fromJson(Map<String, dynamic> json) {
    workingDays = json['working_days'].cast<String>();
    workingHours = json['working_hours'].cast<String>();
    treatmentId = json['treatment_id'].cast<String>();
    sId = json['_id'];
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
    mciId = json['mci_id'];
    specialist = json['specialist'];
    specialistIn = json['specialist_in'];
    doctorType = json['doctor_type'];
    hospitalId = json['hospital_id'];
    approxAppointPerSlot = json['approx_appoint_per_slot'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['working_days'] = this.workingDays;
    data['working_hours'] = this.workingHours;
    data['treatment_id'] = this.treatmentId;
    data['_id'] = this.sId;
    if (this.user != null) {
      data['user'] = this.user.toJson();
    }
    data['mci_id'] = this.mciId;
    data['specialist'] = this.specialist;
    data['specialist_in'] = this.specialistIn;
    data['doctor_type'] = this.doctorType;
    data['hospital_id'] = this.hospitalId;
    data['approx_appoint_per_slot'] = this.approxAppointPerSlot;
    data['__v'] = this.iV;
    return data;
  }
}
