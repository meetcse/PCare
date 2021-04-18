import 'package:dio/dio.dart';
import 'package:pcare/constants/Endpoints.dart';
import 'package:pcare/models/receptionist/UpcomingAppointMentsModel.dart';
import 'package:pcare/network/api_services.dart';

class ReceptionistUpcomingAppointmentsApi {
  var _apiServices = ApiServices.apiServices;

  Future<List<ReceptionistUpcomingAppointmentModel>>
      getReceptionistUpcomingAppointments() async {
    List<ReceptionistUpcomingAppointmentModel>
        _receptionistUpcomingAppointmentModel;

    try {
      final _res = await _apiServices
          .provideGetRequest(Endpoints.getReceptionistUpcomingAppointment);

      _receptionistUpcomingAppointmentModel = (_res as List)
          .map((e) => ReceptionistUpcomingAppointmentModel.fromJson(e))
          .toList();
      print("RESPONSE : " + _res.toString());

      return _receptionistUpcomingAppointmentModel;
    } on DioError catch (e) {
      print("Issue in fetching Upcoming Appointments" + e.toString());
      throw e;
    }
  }
}
