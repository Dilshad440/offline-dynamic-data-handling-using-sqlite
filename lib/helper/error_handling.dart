import 'package:dio/dio.dart';

class ErrorHandling {
  static String getErrorMessage(Response errorModel) {
    switch (errorModel.statusCode) {
      case 200:
        return "Success";
      case 404:
        return "Not Found";
      case 400:
        return "Bad request";
      case 401:
        return "Unauthorised";
      case 500:
        return "Internal server error";
      case 504:
        return "Gateway time out";
      default:
        return "Something Went Wrong";
    }
  }
}
