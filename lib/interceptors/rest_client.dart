import 'package:dio/dio.dart';
import 'package:offline_storage/interceptors/app_interceptors.dart';

class RestClient {
  late Dio dio;
  String baseUrl = "https://api.github.com";

  RestClient() {
    dio = Dio(BaseOptions(
      baseUrl: baseUrl,
      responseType: ResponseType.json,
    ));
    dio.interceptors.add(AppInterceptor());
  }
}
