class ReceptionistModel {
  List<String> doctorId;
  String sId;
  String user;
  String hospitalId;

  ReceptionistModel({
    this.doctorId,
    this.sId,
    this.user,
    this.hospitalId,
  });

  ReceptionistModel.fromJson(Map<String, dynamic> json) {
    doctorId = json['doctor_id'].cast<String>();
    sId = json['_id'];
    user = json['user'];
    hospitalId = json['hospital_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['doctor_id'] = this.doctorId;
    data['_id'] = this.sId;
    data['user'] = this.user;
    data['hospital_id'] = this.hospitalId;

    return data;
  }
}
