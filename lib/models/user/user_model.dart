class UserModel {
  String firstName;
  String lastName;
  String mobileNumber;
  String password;
  String gender;
  String dob;
  String age;
  String userType;
  String profilePic;
  AddressModel address;
  String id;

  UserModel.fromMap(Map<String, dynamic> user) {
    id = user['_id'];
    firstName = user['firstname'];
    lastName = user['lastname'];
    mobileNumber = user['mobilenumber'];
    password = user['password'];
    gender = user['gender'];
    dob = user['dob'];
    age = user['age'];
    userType = user['usertype'];
    profilePic = user['profilepic'];

    if (user['address'] != null) {
      Map<String, dynamic> _address = user['address'];
      address = AddressModel.fromMap(_address);
    }
  }
}

class AddressModel {
  String country;
  String houseno;
  String society;
  String area;
  String city;
  String state;

  AddressModel.fromMap(Map<String, dynamic> address) {
    this.country = address['country'];
    this.houseno = address['houseno'];
    this.society = address['society'];
    this.area = address['area'];
    this.city = address['city'];
    this.state = address['state'];
  }
}
