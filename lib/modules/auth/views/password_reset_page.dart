import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lomfu_app/helpers/localizition/app_langs/keys.dart';
import 'package:lomfu_app/themes/colors.dart';
import 'package:lomfu_app/widgets/custom_app_bar.dart';
import 'package:lomfu_app/widgets/cutom_text_field.dart';
import 'package:lomfu_app/modules/auth/controllers/forgot_password_controller.dart';
import 'package:lomfu_app/helpers/validators.dart';

class PasswordResetPage extends StatelessWidget {
  final ForgotPasswordController controller = ForgotPasswordController();
  final _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  PasswordResetPage({super.key});

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar:CustomAppBar(),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  lblResetPassword.tr,
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color:
                        isDarkMode ? AppColors.darkText : AppColors.lightText,
                  ),
                ),
                SizedBox(height: 30),
                Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        SizedBox(height: 20),
                        CustomTextFormField(
                          controller: passwordController,
                          labelText: hntPassword.tr,
                          prefixIcon: Icons.lock,
                          isPassword: true,
                          validator: validatePassword,
                        ),
                        SizedBox(height: 20),
                        CustomTextFormField(
                          controller: confirmPasswordController,
                          labelText: hntConfirmPassword.tr,
                          prefixIcon: Icons.lock,
                          isPassword: true,
                          validator: (value) {
                            return validateMatchPassword(
                                value, passwordController.text);
                          },
                        ),
                        Align(
                          alignment: Alignment.centerRight,
                          child: TextButton(
                            onPressed: () {
                              // controller.resetPassword(
                              //     emailController.text,
                              //     passwordController.text,
                              //     confirmPasswordController.text);
                            },
                            child:  Text(
                              btnSubmit.tr,
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                      ],
                    )),
               
              ],
            ),
          ),
        ),
      ),
    );
  }
}
