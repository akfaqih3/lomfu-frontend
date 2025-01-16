import 'package:get/get.dart';
import 'package:lomfu_app/API/api_service.dart';
import 'package:lomfu_app/config/constants/api_const.dart';
import 'package:lomfu_app/config/routes.dart';

class ForgotPasswordController extends GetxController {
  final APIService _apiService = APIService();
  final isLoading = false.obs;

  void forgotPassword(String email) async {
    try {
      isLoading(true);
      var data = {"email": email};
      final response = await _apiService.post(Endpoints.forgotPassword, data);
      if (response.statusCode == 200) {
        Get.snackbar("Success", response.body["status"]);
        Get.offNamed(Pages.passwordReset);
      } else {
       
        Get.snackbar("Error", response.body["message"]);
      }

    } catch (e) {
      Get.snackbar("Error", "reset password failed");
    }
    finally{
      isLoading(false);
    }
  }
}