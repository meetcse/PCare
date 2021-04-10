class Endpoints {
  Endpoints._();

  // base url
  static const String baseUrl = "https://pcare-backend.herokuapp.com";
  // base url
  // static const String baseUrlApiary =
  //     "https://private-92549-anjalisoni.apiary-mock.com";

  // receiveTimeout
  static const int receiveTimeout = 3200;

  // connectTimeout
  static const int connectionTimeout = 3200;

  // booking endpoints

  //login endpoints
  static const String loginUser = '/api/auth/login';

  static const String signup = '/api/auth/register';
  static const String getHospitals = '/api/hospital/';
  static const String registerHospital = '/api/hospital/register';
  static const String searchDoctors = '/api/doctor/search/doctor';
}
