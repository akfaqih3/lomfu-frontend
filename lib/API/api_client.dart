import 'package:get/get.dart';
import 'package:get/get_connect/http/src/request/request.dart';
import 'package:lomfu_app/config/constants/api_const.dart';
import 'package:lomfu_app/helpers/token_storage.dart';

class APIClient extends GetConnect {
  final GetHttpClient _httpClient = GetHttpClient(
    baseUrl: baseUrl,
    timeout: Duration(seconds: timeout),
  );

  APIClient() {
    _httpClient.addRequestModifier(
      (Request request) async {
        final String? accessToken = await TokenStorage.getAccessToken();
        request.headers['Authorization'] = 'Bearer $accessToken';
        return request;
      },
    );
  }

  GetHttpClient get httpClient => _httpClient;
}
