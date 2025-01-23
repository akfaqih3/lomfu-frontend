import 'package:get/get.dart';
import 'package:lomfu_app/API/api_helper.dart';
import 'package:lomfu_app/API/api_const.dart';
import 'package:lomfu_app/config/routes.dart';

class ForgotPasswordController extends GetxController {
  final APIHelper _apiService = APIHelper();
  final isLoading = false.obs;

  void forgotPassword(String email) async {
    try {
      isLoading(true);
      var data = {APIKeys.email: email};
      final response = await _apiService.post(Endpoints.forgotPassword, data);
      if (response.statusCode == 200) {
        Get.snackbar("Success", response.body[APIKeys.status]);
        Get.offNamed(Pages.passwordReset);
      } else {
       
        Get.snackbar("Error", response.body[APIKeys.message]);
      }

    } catch (e) {
      Get.snackbar("Error", "reset password failed");
    }
    finally{
      isLoading(false);
    }
  }
}