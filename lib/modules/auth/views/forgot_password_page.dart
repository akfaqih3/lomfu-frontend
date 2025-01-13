import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lomfu_app/themes/colors.dart';
import 'package:lomfu_app/widgets/cutom_text_field.dart';
import 'package:lomfu_app/config/routes.dart';
import 'package:lomfu_app/modules/auth/controllers/forgot_password_controller.dart';
import 'package:lomfu_app/helpers/validators.dart';

class ForgotPasswordPage extends StatelessWidget {
  final ForgotPasswordController controller = ForgotPasswordController();
  final _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();

  ForgotPasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back,
              color: isDarkMode ? AppColors.darkText : AppColors.lightText),
          onPressed: () {
            Get.back(); // العودة إلى الشاشة السابقة
          },
        ),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Forgot Password",
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color:
                        isDarkMode ? AppColors.darkText : AppColors.lightText,
                  ),
                ),
                const SizedBox(height: 30),
                Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        CustomTextFormField(
                          controller: emailController,
                          labelText: "Email",
                          prefixIcon: Icons.email,
                          validator: validateEmail,
                        ),
                        Align(
                            alignment: Alignment.centerRight,
                            child: Obx(() {
                              return controller.isLoading.value
                                  ? const CircularProgressIndicator(
                                      color: AppColors.primary)
                                  : ElevatedButton(
                                      onPressed: _forgotPassword,
                                      child: const Text(
                                        "Submit",
                                      ),
                                    );
                            })),
                        const SizedBox(height: 20),
                      ],
                    )),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Don't have an account? "),
                    GestureDetector(
                      onTap: () {
                        Get.toNamed(Pages.signUp);
                      },
                      child: const Text(
                        "Sign up",
                        style: TextStyle(
                            color: Colors.blue, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _forgotPassword() {
    if (_formKey.currentState!.validate()) {
      controller.forgotPassword(emailController.text);
    }
  }
}
