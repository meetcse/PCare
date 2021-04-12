import 'package:dio/dio.dart';
import 'package:pcare/constants/Endpoints.dart';
import 'package:pcare/models/patient/appointment/AppointmentModel.dart';
import 'package:pcare/network/api_services.dart';

class GetCurrentAppointmentAPI {
  var _apiServices = ApiServices.apiServices;

  Future<AppointmentModel> getCurrentAppointment() async {
    AppointmentModel _appModel;
    try {
      final _res = await _apiServices.provideGetRequest(
        Endpoints.getAppointmentsPatient,
      );

      List<AppointmentModel> _appList =
          (_res as List).map((e) => AppointmentModel.fromJson(e)).toList();
      _appModel = _appList[0];
    } on DioError catch (e) {
      print("Issue in getting appointments" + e.toString());

      throw e;
    }
    return _appModel;
  }
}
