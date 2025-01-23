import 'package:get/get.dart';
import 'package:lomfu_app/modules/auth/models/login_model.dart';
import 'package:lomfu_app/helpers/token_storage.dart';
import 'package:lomfu_app/config/routes.dart';
import 'package:lomfu_app/API/api_helper.dart';
import 'package:lomfu_app/API/api_const.dart';
import 'package:lomfu_app/API/api_exceptions.dart';

class LoginController extends GetxController {
  final APIHelper _apiService = APIHelper();
  final isLoading = false.obs;

  String? accessToken;
  String? refreshToken;

  @override
  void onInit() async {
    super.onInit();
    accessToken = await TokenStorage.getAccessToken();
    refreshToken = await TokenStorage.getRefreshToken();
    if (accessToken != null) {
      Get.offAllNamed(Pages.home);
    }
  }

  void login(String email, String password) async {
    try {
      isLoading(true);
      final response = await _apiService.post(Endpoints.login, {
        APIKeys.email: email,
        APIKeys.password: password,
      });
      if (response.statusCode == 200) {
        final LoginModel loginModel = LoginModel.fromJson(response.body);
        await TokenStorage.saveToken(
            loginModel.accessToken, loginModel.refreshToken);
        Get.offAllNamed(Pages.home);
      } else {
        if (response.statusCode == 401 &&
            response.body[APIKeys.detail] == "Account is not verified.") {
          Get.snackbar("Error", response.body[APIKeys.detail]);
          Get.offAllNamed(Pages.confirmEmail, arguments: email);
        }
        Get.snackbar("Error", response.body[APIKeys.detail]);
      }
    } on ApiExceptions catch (e) {
      errorHandler(e);
    } finally {
      isLoading(false);
    }
  }

  void logout() async {
    try {
      final data = {APIKeys.refreshToken: await TokenStorage.getRefreshToken()};
      final response = await _apiService.post(Endpoints.logout, data);

      if (response.statusCode == 200) {
        await TokenStorage.removeToken();
        Get.offAllNamed(Pages.login);
      } else {
        Get.snackbar("Error", response.body[APIKeys.message]);
      }
    } catch (e) {}
  }
}

refreshToken() async {
  try {
  final APIHelper _apiService = APIHelper();
    final refreshToken = await TokenStorage.getRefreshToken();

    final response = await _apiService.post(Endpoints.refreshToken, {
      APIKeys.refreshToken: refreshToken,
    });

    if (response.statusCode == 200) {
      final data = response.body;
      final accessToken = data[APIKeys.accessToken];
      final refreshToken = data[APIKeys.refreshToken];
      await TokenStorage.saveToken(accessToken, refreshToken);
      return true;
    } else {
      return false;
    }
  } on ApiExceptions catch (e) {
    if (e.error.statusCode == 401) {
      Get.offAllNamed(Pages.login);
      return false;
    }
    return false;
  }
}
