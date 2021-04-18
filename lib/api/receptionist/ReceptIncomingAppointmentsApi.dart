import 'package:dio/dio.dart';
import 'package:pcare/constants/Endpoints.dart';
import 'package:pcare/models/receptionist/IncomingAppointmentsModel.dart';
import 'package:pcare/network/api_services.dart';

class ReceptIncomingAppointmentAPI {
  var _apiServices = ApiServices.apiServices;

  Future<List<IncomingAppointmentModel>> getIncomingAppointments() async {
    List<IncomingAppointmentModel> _incomingAppModel;
    try {
      final _res = await _apiServices.provideGetRequest(
        Endpoints.receptIncomingAppoint,
      );

      if (_res['success'] != null) {
        return [];
      }
      // if (_res != null) {
      _incomingAppModel = (_res as List)
          .map((e) => IncomingAppointmentModel.fromJson(e))
          .toList();
      // }
    } on DioError catch (e) {
      print("Issue in getting incoming appointments" + e.toString());

      throw e;
    }
    return _incomingAppModel;
  }

  Future<dynamic> updateAppointmentStatus(
      int status, String singleAppointmentId) async {
    var _response;
    try {
      _response = await _apiServices
          .providePostRequest(Endpoints.updateIncomingAppoint, {
        "status": status,
        "single_appointment_id": singleAppointmentId,
      });

      // if (_res != null) {
      // _incomingAppModel =(_res as List).map((e) => IncomingAppointmentModel.fromJson(e)).toList();
      // }
    } on DioError catch (e) {
      print("Issue in updating incoming appointments" + e.toString());

      throw e;
    }
    return _response;
  }
}
