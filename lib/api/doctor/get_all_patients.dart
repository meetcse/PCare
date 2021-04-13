import 'package:dio/dio.dart';
import 'package:pcare/constants/Endpoints.dart';
import 'package:pcare/models/doctor/GetAllPatientsModel.dart';
import 'package:pcare/network/api_services.dart';

class GetAllPatientsApi {
  var _apiServices = ApiServices.apiServices;

  Future<List<GetAllPatientsModel>> getAllPatients() async {
    List<GetAllPatientsModel> _getAllPatientsModel;

    try {
      final _res =
          await _apiServices.provideGetRequest(Endpoints.getAllPatients);

      _getAllPatientsModel =
          (_res as List).map((e) => GetAllPatientsModel.fromMap(e)).toList();
      print("RESPONSE : " + _res.toString());
    } on DioError catch (e) {
      print("Issue in fetching Appointment History" + e.toString());
      throw e;
    }
    return _getAllPatientsModel;
  }
}
