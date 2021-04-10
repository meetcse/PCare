import 'package:dio/dio.dart';
import 'package:pcare/constants/Endpoints.dart';
import 'package:pcare/models/doctor/DoctorModel.dart';
import 'package:pcare/models/login/login_model.dart';
import 'package:pcare/models/signup/HospitalModel.dart';
import 'package:pcare/network/api_services.dart';

class SearchDoctorApi {
  var _apiServices = ApiServices.apiServices;

  Future<List<DoctorDetailsModel>> searchDoctors(String doctorName) async {
    List<DoctorDetailsModel> _doctorsDetailModel;
    try {
      final _res = await _apiServices.providePostRequest(
        Endpoints.searchDoctors,
        {"doctor_name": doctorName},
      );

      print("RESPONSE : " + _res.toString());

      _doctorsDetailModel =
          (_res as List).map((e) => DoctorDetailsModel.fromJson(e)).toList();
    } on DioError catch (e) {
      print("Issue in searching doctors" + e.toString());

      throw e;
    }
    return _doctorsDetailModel;
  }
}
