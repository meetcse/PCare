import 'package:dio/dio.dart';
import 'package:pcare/constants/Endpoints.dart';
import 'package:pcare/models/doctor/FullTreatmentModel.dart';
import 'package:pcare/network/api_services.dart';

class AddPatientObservationApi {
  var _apiServices = ApiServices.apiServices;

  Future<String> saveTreatmentDetails(
      String singleAppointmentId,
      String prescription,
      String disease,
      String specialNote,
      String experiments,
      String observation) async {
    try {
      final res = await _apiServices.providePostRequest(
        Endpoints.addTreatment,
        {
          'single_appointment_id': singleAppointmentId,
          'prescription': prescription,
          'disease': disease,
          'special_note': specialNote,
          'experiments': experiments,
          'observation': observation
        },
      );

      if (res["error"] != null) {
        return res['error'];
      } else {
        return res['success'];
      }

      print("RESPONSE : " + res.toString());

      return res;
    } on DioError catch (e) {
      print("Issue in getting full treatment" "" + e.toString());

      throw e;
    }
  }
}
