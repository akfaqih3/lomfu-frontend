import 'package:lomfu_app/API/api_client.dart';
import 'package:lomfu_app/API/api_exceptions.dart';

class APIHelper {
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

  Future<dynamic> delete(String url) async {
    final response = await _client.delete(url);

    if (response.isOk) {
      return response;
    } else {
      throw ApiExceptions(ErrorModel.fromJson(response));
    }
  }

  Future<dynamic> put(String url, dynamic body) async {
    final response = await _client.put(url, body);
    if (response.isOk) {
      return response;
    } else {
      throw ApiExceptions(ErrorModel.fromJson(response));
    }
  }
}
