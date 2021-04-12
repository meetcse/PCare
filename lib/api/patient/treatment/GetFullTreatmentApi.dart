import 'package:dio/dio.dart';
import 'package:pcare/constants/Endpoints.dart';
import 'package:pcare/models/patient/appointment/treatment/GetFullTreatmentModel.dart';
import 'package:pcare/network/api_services.dart';

class GetFullTreatmentApi {
  var _apiServices = ApiServices.apiServices;

  Future<GetFullTreatmentModel> getFullTreatment(String fullTreatmentID) async {
    GetFullTreatmentModel _fullTreatmentModel;
    try {
      final _res = await _apiServices
          .providePostRequest(Endpoints.getFullTreatmentPatient, {
        "full_treatment_id": fullTreatmentID,
      });

      _fullTreatmentModel = GetFullTreatmentModel.fromJson(_res);
    } on DioError catch (e) {
      print("Issue in getting full treatment" + e.toString());

      throw e;
    }
    return _fullTreatmentModel;
  }
}
