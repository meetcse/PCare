import 'package:dio/dio.dart';
import 'package:pcare/constants/Endpoints.dart';
import 'package:pcare/network/api_services.dart';

class BookAppointmentApi {
  var _apiServices = ApiServices.apiServices;

  Future<bool> bookAppointment(
      String doctorId, String appointmentTime, String appointmentDate) async {
    bool _result;
    try {
      final _res = await _apiServices.providePostRequest(
        Endpoints.bookNewAppointment,
        {
          "doctor_id": doctorId,
          "appointment_time": appointmentTime,
          "appointment_date": appointmentDate,
        },
      );

      if (_res != null) {
        if (_res['status'].toString().toLowerCase() == "pending") {
          _result = true;
        } else {
          _result = false;
        }
      } else {
        _result = false;
      }
    } on DioError catch (e) {
      print("Issue in searching doctors" + e.toString());

      throw e;
    }
    return _result;
  }
}
