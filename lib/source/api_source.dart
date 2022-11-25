import 'package:offline_storage/interceptors/rest_client.dart';
import 'package:offline_storage/response/response.dart';

class ApiSource {
  final _client = RestClient();

  Future<List<JakeWharton>> fetchData(int page) async {
    final response = await _client.dio.get(
      "/users/JakeWharton/repos",
      queryParameters: {
        "page": page,
      },
    );
    final data = response.data as List;
    return data.map<JakeWharton>((e) => JakeWharton.fromJson(e)).toList();
  }
}
