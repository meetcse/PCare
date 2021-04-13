class HospitalModel {
  String id;
  String hospitalName;
  String hospitalAddress;
  // int iV;

  HospitalModel({
    this.id,
    this.hospitalName,
    this.hospitalAddress,
  });

  HospitalModel.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    hospitalName = json['hospital_name'];
    hospitalAddress = json['hospital_address'];
    // iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.id;
    data['hospital_name'] = this.hospitalName;
    data['hospital_address'] = this.hospitalAddress;
    // data['__v'] = this.iV;
    return data;
  }
}
