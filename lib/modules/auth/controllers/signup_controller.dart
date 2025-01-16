import 'package:get/get.dart';
import 'package:lomfu_app/API/api_service.dart';
import 'package:lomfu_app/config/constants/api_const.dart';
import 'package:lomfu_app/config/routes.dart';

class SignupController extends GetxController {
  final APIService _apiService = APIService();
  final agreeToTerms = false.obs;
  final isLoading = false.obs;
  final isPasswordMatch = false.obs;
  static final roles = {
    "teacher": "Teacher",
    "student": "Student",
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
        "name": name,
        "email": email,
        "phone": phone,
        "role": role,
        "password": password,
        "confirm_password":confirmPassword
      };
      var response = await _apiService.post(
        Endpoints.register,
        data,
      );
     
      if (response.statusCode == 201) {
        Get.snackbar("Success", "Signup Successfully");
        Get.toNamed(Pages.confirmEmail,arguments: data["email"]);
      } else {
        Get.snackbar(
          "Error",
          response.body["errors"][0]["message"],
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
