import 'package:lomfu_app/API/api_client.dart';

class APIService {
  final APIClient _client = APIClient();

  Future<dynamic> get(String url) async {
    return await _client.get(url);
  }

  Future<dynamic> post(String url, dynamic body) async {
    final response = await _client.post(url, body);
    return response;
  }
}
