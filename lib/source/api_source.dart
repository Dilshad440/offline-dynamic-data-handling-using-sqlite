import 'package:offline_storage/interceptors/rest_client.dart';
import 'package:offline_storage/response/base_response.dart';
import 'package:offline_storage/response/jake_list_response.dart';

class ApiSource {
  final _client = RestClient();

  Future<BaseResponseModel<JakeListResponse>> fetchData(int page) async {
    final response = await _client.dio.get(
      "/users/JakeWharton/repos",
      queryParameters: {
        "page": page,
      },
    );
    return BaseResponseModel(
      body: JakeListResponse.fromJson(response.data),
      message: response.statusMessage,
      status: response.statusCode,
    );
  }
}
