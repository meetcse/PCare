import 'package:dio/dio.dart';
import 'package:pcare/constants/Endpoints.dart';
import 'package:pcare/models/signup/HospitalModel.dart';
import 'package:pcare/network/api_services.dart';

class GetHospitalApi {
  var _apiServices = ApiServices.apiServices;

  Future<List<HospitalModel>> getHospital(String hospitalName) async {
    List<HospitalModel> _hospitalModel;
    try {
      final _res = await _apiServices.providePostRequest(
        Endpoints.getHospitals,
        {"hospital_name": hospitalName},
      );

      print("RESPONSE : " + _res.toString());

      _hospitalModel =
          (_res as List).map((e) => HospitalModel.fromJson(e)).toList();
    } on DioError catch (e) {
      print("Issue in searching hospital" + e.toString());

      throw e;
    }
    return _hospitalModel;
  }

  Future<HospitalModel> createHospital(
      String hospitalName, String hospitalAddress) async {
    HospitalModel _hospitalModel;
    try {
      final _res = await _apiServices.providePostRequest(
        Endpoints.registerHospital,
        {
          "hospital_name": hospitalName,
          "hospital_address": hospitalAddress,
        },
      );

      print("RESPONSE : " + _res.toString());

      _hospitalModel = HospitalModel.fromJson(_res);
    } on DioError catch (e) {
      print("Issue in Registering hospital" + e.toString());

      throw e;
    }
    return _hospitalModel;
  }
}
