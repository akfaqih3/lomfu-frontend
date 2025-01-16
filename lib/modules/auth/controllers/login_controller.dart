import 'package:get/get.dart';
import 'package:lomfu_app/modules/auth/models/login_model.dart';
import 'package:lomfu_app/helpers/token_storage.dart';
import 'package:lomfu_app/config/routes.dart';
import 'package:lomfu_app/API/api_service.dart';
import 'package:lomfu_app/config/constants/api_const.dart';

class LoginController extends GetxController {
  final APIService _apiService = APIService();
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
        'email': email,
        'password': password,
      });

      if (response.statusCode == 200) {
        final LoginModel loginModel = LoginModel.fromJson(response.body);
        await TokenStorage.saveToken(
            loginModel.accessToken, loginModel.refreshToken);
        Get.offAllNamed(Pages.home);
      } else {
        if (response.statusCode == 401 &&
            response.body["detail"] == "Account is not verified.") {
          Get.snackbar("Error", response.body["detail"]);
          Get.offAllNamed(Pages.confirmEmail, arguments: email);
        }
        Get.snackbar("Error", response.body["message"]);
      }
    } catch (e) {
    } finally {
      isLoading(false);
    }
  }

  void logout() async {
    try {
      final data = {"refresh": await TokenStorage.getRefreshToken()};
      final response = await _apiService.post(Endpoints.logout, data);

      if (response.statusCode == 200) {
        await TokenStorage.removeToken();
        Get.offAllNamed(Pages.login);
      } else {
        Get.snackbar("Error", response.body["message"]);
      }
    } catch (e) {}
  }
}
