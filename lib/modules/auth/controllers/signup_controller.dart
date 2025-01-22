import 'package:get/get.dart';
import 'package:lomfu_app/API/api_service.dart';
import 'package:lomfu_app/API/api_const.dart';
import 'package:lomfu_app/config/routes.dart';
import 'package:lomfu_app/helpers/localizition/app_langs/keys.dart';

class SignupController extends GetxController {
  final APIService _apiService = APIService();
  final agreeToTerms = false.obs;
  final isLoading = false.obs;
  final isPasswordMatch = false.obs;
  static final roles = {
    "teacher": lblTeacher,
    "student": lblStudent,
  };

  final selectedRole = roles.keys.first.obs;


  Future<void> signup(
    String name,
    String email,
    String role,
    String? phone,
    String password,
    String confirmPassword
  ) async {
    try {
      isLoading(true);
      final data = {
        APIKeys.name: name,
        APIKeys.email: email,
        APIKeys.phone: phone,
        APIKeys.role: role,
        APIKeys.password: password,
        APIKeys.confirmPassword:confirmPassword
      };
      var response = await _apiService.post(
        Endpoints.register,
        data,
      );
     
      if (response.statusCode == 201) {
        Get.snackbar("Success", "Signup Successfully");
        Get.toNamed(Pages.confirmEmail,arguments: data[APIKeys.email]);
      } else {
        Get.snackbar(
          "Error",
          response.body[APIKeys.errors][0][APIKeys.message],
        );
      }
    } catch (e) {
      Get.snackbar("Error", "Signup Failed");
    }
    finally{
      isLoading(false);
    }
  }

  void onAgreeToTermsChanged(bool? value) {
    agreeToTerms(value ?? agreeToTerms.value);
  }
}
