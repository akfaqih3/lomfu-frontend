import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lomfu_app/helpers/localazition/app_langs/keys.dart';
import 'package:lomfu_app/widgets/custom_app_bar.dart';
import 'package:lomfu_app/widgets/cutom_text_field.dart';
import 'package:lomfu_app/themes/colors.dart';
import 'package:lomfu_app/config/routes.dart';
import 'package:lomfu_app/modules/auth/controllers/signup_controller.dart';
import 'package:lomfu_app/helpers/validators.dart';

class SignUpPage extends StatelessWidget {
  final SignupController controller = Get.put(SignupController());
  final _formKey = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      appBar: CustomAppBar(),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  lblRegister.tr,
                  style: Get.textTheme.titleLarge,
                ),
                SizedBox(height: 5),
                Text(
                  lblEnterYourDetails.tr,
                  style: Get.textTheme.titleSmall,
                ),
                SizedBox(height: 40),
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      CustomTextFormField(
                        labelText: hntName.tr,
                        controller: nameController,
                        prefixIcon: Icons.person,
                        validator: validateName,
                      ),
                      SizedBox(height: 20),
                      CustomTextFormField(
                        labelText: hntEmail.tr,
                        controller: emailController,
                        prefixIcon: Icons.email,
                        validator: validateEmail,
                      ),
                      SizedBox(height: 20),
                      Container(
                        child: Obx(() {
                          final roles = SignupController.roles;
                          return DropdownButtonFormField(
                            value: controller.selectedRole.value,
                            isExpanded: true,
                            items: roles.keys.map((e) {
                              return DropdownMenuItem(
                                value: e,
                                child: Container(
                                  child:
                                      Text(roles[e]!.tr, style: Get.textTheme.titleMedium),
                                ),
                              );
                            }).toList(),
                            onChanged: (value) {
                              controller.selectedRole(value);
                            },
                            decoration: InputDecoration(
                              floatingLabelAlignment:
                                  FloatingLabelAlignment.center,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              contentPadding: EdgeInsets.symmetric(
                                horizontal: 15,
                                vertical: 10,
                              ),
                              alignLabelWithHint: true,
                              labelText: hntRole.tr,
                              labelStyle: Get.textTheme.labelLarge,
                            ),
                          );
                        }),
                      ),
                      SizedBox(height: 20),
                      CustomTextFormField(
                        labelText:hntPhone.tr,
                        controller: phoneController,
                        prefixIcon: Icons.phone,
                        validator: validatephoneNumber,
                      ),
                      SizedBox(height: 20),
                      CustomTextFormField(
                        labelText: hntPassword.tr,
                        controller: passwordController,
                        prefixIcon: Icons.lock,
                        isPassword: true,
                        validator: validatePassword,
                      ),
                      SizedBox(height: 20),
                      CustomTextFormField(
                        labelText: hntConfirmPassword.tr,
                        controller: confirmPasswordController,
                        prefixIcon: Icons.lock,
                        isPassword: true,
                        validator: (value) {
                          return validateMatchPassword(
                              value, passwordController.text);
                        },
                      ),
                      Row(
                        children: [
                          Obx(() {
                            return Checkbox(
                              value: controller.agreeToTerms.value,
                              onChanged: (value) {
                                controller.onAgreeToTermsChanged(value);
                              },
                              checkColor: isDarkMode? AppColors.primary:AppColors.white,
                              activeColor: isDarkMode? AppColors.white:AppColors.primary,
                            );
                          }),
                          Expanded(
                            child: Text(
                              lblPolicyPrivacy.tr,
                              style: Get.textTheme.titleSmall,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                      Obx(() {
                        if (controller.isLoading.value) {
                          return const CircularProgressIndicator(
                            color: AppColors.primary,
                          );
                        }
                        return ElevatedButton(
                          onPressed: controller.agreeToTerms.value
                              ? () {
                                  _signup();
                                }
                              : null,
                          style: ElevatedButton.styleFrom(
                            minimumSize: Size(double.infinity, 50),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          child: Text(
                            btnRegister.tr,
                          ),
                        );
                      }),
                    ],
                  ),
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(lblAlreadyHaveAccount.tr,
                    style: Get.textTheme.labelMedium,),
                    GestureDetector(
                      onTap: () {
                        Get.offNamed(Pages.login);
                      },
                      child: Text(
                        btnLogin.tr,
                        style: Get.textTheme.labelMedium!
                            .copyWith(color: AppColors.primary),
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

  void _signup() {
    if (_formKey.currentState!.validate()) {
      controller.signup(
        nameController.text,
        emailController.text,
        controller.selectedRole.value,
        phoneController.text,
        passwordController.text,
        confirmPasswordController.text,
      );
    }
  }
}
