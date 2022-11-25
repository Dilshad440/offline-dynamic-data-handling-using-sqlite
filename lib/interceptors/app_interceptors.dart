import 'package:dio/dio.dart';

class AppInterceptor extends Interceptor {
  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) {
    print("${options.method} ${options.path}");
    print(options.uri);
    super.onRequest(options, handler); //add this line
  }

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    print(err.message);
    super.onError(err, handler); //add this line
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    print(response.statusCode);
    print(response.data);
    print(handler.isCompleted);
    // do something before response
    super.onResponse(response, handler); //add this line
  }
}