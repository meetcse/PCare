import 'package:dio/dio.dart';
import 'package:pcare/constants/Endpoints.dart';
import 'package:pcare/models/doctor/FullTreatmentModel.dart';
import 'package:pcare/network/api_services.dart';

class AddPatientObservationApi {
  var _apiServices = ApiServices.apiServices;

  Future<FullTreatmentModel> getFullTreatment(String fullTreatmentId) async {
    FullTreatmentModel fullTreatmentModel;
    try {
      final res = await _apiServices.providePostRequest(
        Endpoints.getFullTreatment,
        {
          'full_treatment_id': fullTreatmentId,
        },
      );

      fullTreatmentModel = FullTreatmentModel.fromJson(res);

      print("RESPONSE : " + res.toString());
    } on DioError catch (e) {
      print("Issue in getting full treatment" "" + e.toString());

      throw e;
    }
    return fullTreatmentModel;
  }
}
