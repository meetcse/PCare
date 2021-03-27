class UserModel {
  String firstname;
  String lastname;
  String mobilenumber;
  String password;
  String gender;
  String dob;
  String age;
  String userType;
  String profilePic;
  AddressModel address;
  String society;
  String id;

  UserModel(
      {this.firstname,
      this.lastname,
      this.mobilenumber,
      this.password,
      this.gender,
      this.dob,
      this.age,
      this.userType,
      this.society});

  UserModel.fromMap(Map<String, dynamic> user) {
    id = user['_id'] ?? '';
    firstname = user['firstname'] ?? '';
    lastname = user['lastname'] ?? '';
    mobilenumber = user['mobilenumber'] ?? '';
    password = user['password'] ?? '';
    gender = user['gender'] ?? '';
    dob = user['dob'] ?? '';
    age = user['age'] ?? '';
    userType = user['usertype'] ?? '';
    profilePic = user['profilepic'] ?? '';

    if (user['address'] != null) {
      Map<String, dynamic> _address = user['address'];
      address = AddressModel.fromMap(_address);
    }
  }

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['firstname'] = this.firstname ?? '';
    data['lastname'] = this.lastname ?? '';
    data['mobilenumber'] = this.mobilenumber ?? '';
    data['password'] = this.password ?? '';
    data['gender'] = this.gender ?? '';
    data['dob'] = this.dob ?? '';
    data['usertype'] = this.userType ?? '';
    data['country'] = "NA";
    data['state'] = "NA";
    data['city'] = "NA";
    data['area'] = "NA";
    data['society'] = this.society ?? '';
    data['houseno'] = "NA";

    return data;
  }
}

class AddressModel {
  String country;
  String state;
  String city;
  String area;
  String society;
  String houseno;

  AddressModel({
    this.country,
    this.houseno,
    this.society,
    this.area,
    this.city,
    this.state,
  });

  AddressModel.fromMap(Map<String, dynamic> address) {
    this.country = address['country'] ?? '';
    this.houseno = address['houseno'] ?? '';
    this.society = address['society'] ?? '';
    this.area = address['area'] ?? '';
    this.city = address['city'] ?? '';
    this.state = address['state'] ?? '';
  }
}
