import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lomfu_app/helpers/localizition/app_langs/keys.dart';
import 'package:lomfu_app/home.dart';
import 'package:lomfu_app/themes/colors.dart';
import 'package:lomfu_app/widgets/cutom_text_field.dart';
import 'package:lomfu_app/config/routes.dart';
import 'package:lomfu_app/modules/auth/controllers/forgot_password_controller.dart';
import 'package:lomfu_app/helpers/validators.dart';
import 'package:lomfu_app/widgets/custom_app_bar.dart';

class ForgotPasswordPage extends StatelessWidget {
  final ForgotPasswordController controller = ForgotPasswordController();
  final _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();

  ForgotPasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
     AppTheme.isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: CustomAppBar(),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  lblForgotPassword.tr,
                  style: Get.textTheme.titleLarge,
                ),
                const SizedBox(height: 30),
                Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        CustomTextFormField(
                          controller: emailController,
                          labelText: hntEmail.tr,
                          prefixIcon: Icons.email,
                          validator: validateEmail,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Align(
                            alignment: AppLanguage.appLang == AppLanguage.arKey
                                ? Alignment.centerRight
                                : Alignment.centerLeft,
                            child: Obx(() {
                              return controller.isLoading.value
                                  ? const CircularProgressIndicator(
                                      color: AppColors.primary)
                                  : ElevatedButton(
                                      onPressed: _forgotPassword,
                                      child: Text(
                                        btnSend.tr,
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
                    Text(
                      lblDontHaveAccount.tr,
                      style: Get.textTheme.titleSmall,
                    ),
                    GestureDetector(
                      onTap: () {
                        Get.toNamed(Pages.signUp);
                      },
                      child: const Text(
                        lblRegister,
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
