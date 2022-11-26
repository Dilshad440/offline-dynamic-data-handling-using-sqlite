import 'package:offline_storage/response/response.dart';

class JakeListresponse {
  List<JakeWharton> jake = [];

  JakeListresponse(this.jake);
  JakeListresponse.fromJson(List json) {
    jake = [];
    for (var v in json) {
      jake.add(JakeWharton.fromJson(v));
    }
  }
}
