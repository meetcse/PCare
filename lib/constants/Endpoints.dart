class Endpoints {
  Endpoints._();

  // base url
  static const String baseUrl = "https://pcare-backend.herokuapp.com";
  // base url
  // static const String baseUrlApiary =
  //     "https://private-92549-anjalisoni.apiary-mock.com";

  // receiveTimeout
  static const int receiveTimeout = 32000;

  // connectTimeout
  static const int connectionTimeout = 32000;

  // booking endpoints

  //login endpoints
  static const String loginUser = '/api/auth/login';

  //registration endpoints
  static const String registerUser = '/api/auth/register';

  //upcoming appointments for Doctor
  static const String getUpcomingAppointment = '/api/appointment/upcoming';

  static const String getAppointmentsHistory = '/api/appointment/doctor/all';

  static const String getTodaysAppointment = '/api/appointment/today';

  static const String getAllPatients = '/api/doctor/mypatients';

  static const String getFullTreatment = '/api/treatment/full';
  static const String signup = '/api/auth/register';
  static const String getHospitals = '/api/hospital/';
  static const String registerHospital = '/api/hospital/register';
  static const String searchDoctors = '/api/doctor/search/doctor';
  static const String getDoctors = '/api/doctor/';
  static const String bookNewAppointment = '/api/appointment/book/new';
  static const String getAppointmentsPatient = '/api/appointment/patient';
  static const String getFullTreatmentPatient = '/api/treatment/full';
  static const String addTreatment = '/api/treatment/add';
}
