class DoctorDetailsModel {
  List<String> workingDays;
  List<String> workingHours;
  List<Null> treatmentId;
  String sId;
  String user;
  String mciId;
  bool specialist;
  String specialistIn;
  String doctorType;
  int approxAppointPerSlot;
  String receptionistId;

  DoctorDetailsModel({
    this.workingDays,
    this.workingHours,
    this.treatmentId,
    this.sId,
    this.user,
    this.mciId,
    this.specialist,
    this.specialistIn,
    this.doctorType,
    this.approxAppointPerSlot,
    this.receptionistId,
  });

  DoctorDetailsModel.fromJson(Map<String, dynamic> json) {
    workingDays = json['working_days'].cast<String>();
    workingHours = json['working_hours'].cast<String>();
    if (json['treatment_id'] != null) {
      treatmentId = [];
      // json['treatment_id'].forEach((v) {
      //   treatmentId.add(new Null.fromJson(v));
      // });
    }
    sId = json['_id'];
    user = json['user'];
    mciId = json['mci_id'];
    specialist = json['specialist'];
    specialistIn = json['specialist_in'];
    doctorType = json['doctor_type'];
    approxAppointPerSlot = json['approx_appoint_per_slot'];
    receptionistId = json['receptionist_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['working_days'] = this.workingDays;
    data['working_hours'] = this.workingHours;
    // if (this.treatmentId != null) {
    //   data['treatment_id'] = this.treatmentId.map((v) => v.toJson()).toList();
    // }
    data['_id'] = this.sId;
    data['user'] = this.user;
    data['mci_id'] = this.mciId;
    data['specialist'] = this.specialist;
    data['specialist_in'] = this.specialistIn;
    data['doctor_type'] = this.doctorType;
    data['approx_appoint_per_slot'] = this.approxAppointPerSlot;
    data['receptionist_id'] = this.receptionistId;

    return data;
  }
}
