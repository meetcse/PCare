import 'package:dio/dio.dart';
import 'package:pcare/constants/Endpoints.dart';
import 'package:pcare/models/doctor/UpcomingAppointmentModel.dart';
import 'package:pcare/network/api_services.dart';

class UpcomingAppointmentsApi {
  var _apiServices = ApiServices.apiServices;

  Future<List<UpcomingAppointmentModel>> getUpcomingAppointments() async {
    List<UpcomingAppointmentModel> _upcomingAppointmentModel;

    try {
      final _res = await _apiServices
          .provideGetRequest(Endpoints.getUpcomingAppointment);

      _upcomingAppointmentModel = (_res as List)
          .map((e) => UpcomingAppointmentModel.fromMap(e))
          .toList();
      print("RESPONSE : " + _res.toString());
    } on DioError catch (e) {
      print("Issue in fetching Upcoming Appointments" + e.toString());
      throw e;
    }
    return _upcomingAppointmentModel;
  }
}
