class SignupModel {
  String firstname;
  String lastname;
  String mobilenumber;
  String houseno;
  String area;
  String city;
  String society;
  String state;
  String password;
  String gender;
  String dob;
  String usertype;
  String mci_id;
  bool specialist;
  String specialist_in;
  String doctor_type;
  String hospital_id;
  int approx_appoint_per_slot;
  String receptionist_id;
  List<String> working_days;
  List<String> working_hours;
  String doctor_id;
  SignupModel({
    this.firstname,
    this.lastname,
    this.mobilenumber,
    this.houseno,
    this.area,
    this.city,
    this.society,
    this.state,
    this.password,
    this.gender,
    this.dob,
    this.usertype,
    this.mci_id,
    this.specialist,
    this.specialist_in,
    this.doctor_type,
    this.hospital_id,
    this.approx_appoint_per_slot,
    this.receptionist_id,
    this.working_days,
    this.working_hours,
    this.doctor_id,
  });

  Map<String, dynamic> toMap() {
    return {
      'firstname': firstname ?? '',
      'lastname': lastname ?? '',
      'mobilenumber': mobilenumber ?? '',
      'houseno': houseno ?? '1',
      'area': area ?? 'area',
      'city': city ?? 'city',
      'society': society ?? 'soc',
      'state': state ?? 'state',
      'password': password ?? '',
      'gender': gender ?? '',
      'dob': dob ?? '',
      'usertype': usertype ?? '',
      'mci_id': mci_id ?? '',
      'specialist': specialist ?? false,
      'specialist_in': specialist_in ?? 'No Specialist',
      'doctor_type': doctor_type ?? '',
      'hospital_id': hospital_id ?? '',
      'approx_appoint_per_slot': approx_appoint_per_slot ?? 1,
      'receptionist_id': receptionist_id ?? '',
      'working_days': working_days ?? [],
      'working_hours': working_hours ?? [],
      'doctor_id': doctor_id ?? '',
    };
  }

  factory SignupModel.fromMap(Map<String, dynamic> map) {
    return SignupModel(
      firstname: map['firstname'] ?? '',
      lastname: map['lastname'] ?? '',
      mobilenumber: map['mobilenumber'] ?? '',
      houseno: map['houseno'] ?? '',
      area: map['area'] ?? '',
      city: map['city'] ?? '',
      society: map['society'] ?? '',
      state: map['state'] ?? '',
      password: map['password'] ?? '',
      gender: map['gender'] ?? '',
      dob: map['dob'] ?? '',
      usertype: map['usertype'] ?? '',
      mci_id: map['mci_id'] ?? '',
      specialist: map['specialist'] ?? false,
      specialist_in: map['specialist_in'] ?? '',
      doctor_type: map['doctor_type'] ?? '',
      hospital_id: map['hospital_id'] ?? '',
      approx_appoint_per_slot: map['approx_appoint_per_slot'] ?? 1,
      receptionist_id: map['receptionist_id'] ?? '',
      working_days: List<String>.from(map['working_days']) ?? [],
      working_hours: List<String>.from(map['working_hours']) ?? [],
      doctor_id: map['doctor_id'] ?? '',
    );
  }
}
