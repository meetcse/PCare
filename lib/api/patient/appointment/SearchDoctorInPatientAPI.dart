import 'package:dio/dio.dart';
import 'package:pcare/constants/Endpoints.dart';
import 'package:pcare/models/patient/appointment/SearchDoctorInPatientModel.dart';
import 'package:pcare/network/api_services.dart';

class SearchDoctorInPatientApi {
  var _apiServices = ApiServices.apiServices;

  Future<List<SearchDoctorsInPatientModel>> getDoctors() async {
    List<SearchDoctorsInPatientModel> _searchDoctorModel;
    try {
      final _res = await _apiServices.provideGetRequest(
        Endpoints.getDoctors,
      );

      print("RESPONSE : " + _res.toString());

      _searchDoctorModel = (_res as List)
          .map((e) => SearchDoctorsInPatientModel.fromJson(e))
          .toList();
    } on DioError catch (e) {
      print("Issue in searching doctors" + e.toString());

      throw e;
    }
    return _searchDoctorModel;
  }
}
