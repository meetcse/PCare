import 'package:dio/dio.dart';
import 'package:pcare/constants/Endpoints.dart';
import 'package:pcare/models/patient/appointment/AppointmentModel.dart';
import 'package:pcare/network/api_services.dart';

class GetMyAppointmentsApi {
  var _apiServices = ApiServices.apiServices;

  Future<List<AppointmentModel>> getCurrentAppointment() async {
    List<AppointmentModel> _appModel;
    try {
      final _res = await _apiServices.provideGetRequest(
        Endpoints.getAppointmentsPatient,
      );

      _appModel =
          (_res as List).map((e) => AppointmentModel.fromJson(e)).toList();
    } on DioError catch (e) {
      print("Issue in getting appointments" + e.toString());

      throw e;
    }
    return _appModel;
  }
}
