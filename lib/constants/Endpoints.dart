class Endpoints {
  Endpoints._();

  // base url
  static const String baseUrl = "https://pcare-backend.herokuapp.com";
  // base url
  // static const String baseUrlApiary =
  //     "https://private-92549-anjalisoni.apiary-mock.com";

  // receiveTimeout
  static const int receiveTimeout = 1200;

  // connectTimeout
  static const int connectionTimeout = 1200;

  // booking endpoints

  //login endpoints
  static const String loginUser = '/api/auth/login';
}
