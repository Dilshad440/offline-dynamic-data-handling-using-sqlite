import 'package:offline_storage/response/response.dart';

class JakeListResponse {
  List<JakeWharton> jake = [];

  JakeListResponse(this.jake);
  JakeListResponse.fromJson(List json) {
    jake = [];
    for (var v in json) {
      jake.add(JakeWharton.fromJson(v));
    }
  }
}
