import 'package:dio/dio.dart';
import 'package:pcare/Utils/dio/dio_error_util.dart';
import 'package:pcare/constants/Endpoints.dart';
import 'package:pcare/constants/preferences.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ApiServices {
  // String url;
  ApiServices._() {
    dioOptions();
  }

  // ApiServices(this.url);
  static final ApiServices apiServices = ApiServices._();
  static Dio dio = Dio();

  dioOptions() {
    dio
      ..options.baseUrl = Endpoints.baseUrl
      ..options.connectTimeout = Endpoints.connectionTimeout
      ..options.receiveTimeout = Endpoints.receiveTimeout
      ..options.responseType = ResponseType.json
      ..options.headers = {'Content-Type': 'application/json; charset=utf-8'}
      ..interceptors.add(LogInterceptor(
        request: true,
        responseBody: true,
        requestBody: true,
        requestHeader: true,
      ))
      ..interceptors.add(
        InterceptorsWrapper(
          onRequest: (RequestOptions options, handler) async {
            // getting shared pref instance
            var prefs = await SharedPreferences.getInstance();

            // getting token
            var token = prefs.getString(Preferences.authToken);

            if (token != null) {
              options.headers.putIfAbsent('Authorization', () => token);
              options.headers.addAll({"authorization": "Bearer $token"});
              return handler.next(options);
            } else {
              print('Auth token is null');
              return handler.next(options);
            }
          },
        ),
      );
  }

  provideGetRequest(String url, {Map<String, dynamic> queryParameters}) async {
    var errorMessage;
    Response res = await dio
        .get(url,
            queryParameters: queryParameters != null ? queryParameters : null)
        .catchError((error) {
      errorMessage = DioErrorUtil.handleError(error);
      print("ERROR in API RES : " + errorMessage);
      throw error;
    });
    return res.data;
  }

  Future providePostRequest(String url, dynamic data) async {
    var errorMessage;
    Response res = await dio
        .post(
      url,
      data: data,
      options: Options(
          followRedirects: false,
          validateStatus: (status) {
            return status < 500;
          }),
    )
        .catchError((error) {
      errorMessage = DioErrorUtil.handleError(error);
      print("ERROR in API RES : " + errorMessage);
      throw error;
    });

    return res.data;
  }

  // Future providePostRequestFormData(String url, dynamic data) async {
  //   var errorMessage;
  //   print("Api****" + url);
  //   print("data****" + data.toString());
  //   Response res =
  //       await dio.post(url, data: FormData.fromMap(data)).catchError((error) {
  //     errorMessage = DioErrorUtil.handleError(error);
  //     print("ERROR in API RES : " + errorMessage);
  //     throw error;
  //   });

  //   return res.data;
  // }
}
