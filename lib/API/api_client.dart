import 'package:get/get.dart';
import 'package:get/get_connect/http/src/request/request.dart';
import 'package:lomfu_app/API/api_const.dart';
import 'package:lomfu_app/API/api_exceptions.dart';
import 'package:lomfu_app/helpers/token_storage.dart';
import 'package:lomfu_app/API/api_service.dart';
import 'package:lomfu_app/modules/auth/controllers/login_controller.dart';

class APIClient extends GetConnect {
  APIClient() {
    httpClient.baseUrl = baseUrl;
    httpClient.timeout = Duration(seconds: timeout);

    httpClient.addRequestModifier(
      (Request request) async {
        final String? accessToken = await TokenStorage.getAccessToken();
        request.headers['Authorization'] = '${APIKeys.tokenType} $accessToken';
        return request;
      },
    );

    httpClient.addResponseModifier((request, response) async {
      if (response.statusCode == 401 &&
          ErrorModel.fromJson(response).message == APIKeys.invalidToken) {
        final success = await refreshToken();
        if (success) {
          final newRequest = request.copyWith(headers: {
            'Authorization':
                '${APIKeys.tokenType} ${await TokenStorage.getAccessToken()}',
          });
          return await httpClient.request(
            newRequest.url.toString(),
            newRequest.method,
            headers: newRequest.headers,
            body: newRequest.files ?? newRequest.bodyBytes,
          );
          
        } else {
          return Future.error(response);
        }
      }
      return response;
    });
  }

}
