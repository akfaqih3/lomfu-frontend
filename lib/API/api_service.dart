import 'package:lomfu_app/API/api_client.dart';
import 'package:lomfu_app/API/api_exceptions.dart';

class APIService {
  final APIClient _client = APIClient();

  Future<dynamic> get(String url) async {
    final response = await _client.get(url);
    if (response.isOk) {
      return response;
    } else {
      throw ApiExceptions(ErrorModel.fromJson(response));
    }
  }

  Future<dynamic> post(String url, dynamic body) async {
    final response = await _client.post(url, body);
  
    if (response.isOk) {
      return response;
    } else {
      throw ApiExceptions(ErrorModel.fromJson(response));
    }
  }
}
