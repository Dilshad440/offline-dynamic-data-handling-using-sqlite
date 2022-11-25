import 'package:internet_connection_checker/internet_connection_checker.dart';

class Permission {
  Future<bool> checkInternet() async {
    return await InternetConnectionChecker().hasConnection;
  }
}
