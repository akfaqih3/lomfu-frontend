import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lomfu_app/widgets/custom_app_bar.dart';
import 'package:lomfu_app/widgets/cutom_text_field.dart';
import 'package:lomfu_app/themes/colors.dart';
import 'package:lomfu_app/config/routes.dart';
import 'package:lomfu_app/modules/auth/controllers/signup_controller.dart';
import 'package:lomfu_app/helpers/validators.dart';

class SignUpPage extends StatelessWidget {
  final SignupController controller = SignupController();
  final _formKey = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
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
                  "Sign Up",
                  style: Get.textTheme.titleLarge,
                ),
                SizedBox(height: 5),
                Text(
                  "Enter your details below to sign up",
                  style: Get.textTheme.bodySmall,
                ),
                SizedBox(height: 40),
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      CustomTextFormField(
                        labelText: 'Name',
                        controller: nameController,
                        prefixIcon: Icons.person,
                        validator: validateName,
                      ),
                      SizedBox(height: 20),
                      CustomTextFormField(
                        labelText: 'Email',
                        controller: emailController,
                        prefixIcon: Icons.email,
                        validator: validateEmail,
                      ),
                      SizedBox(height: 20),
                      Container(
                        child: Obx(() {
                          return DropdownButtonFormField(
                            value: controller.selectedRole.value,
                            isExpanded: true,
                            items: SignupController.roles.keys.map((e) {
                              return DropdownMenuItem(
                                value: e,
                                child: Container(
                                  child:
                                      Text(e, style: Get.textTheme.bodyLarge),
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
                              labelText: 'Role',
                              labelStyle: Get.textTheme.bodyLarge!
                                  .copyWith(fontSize: 18),
                            ),
                          );
                        }),
                      ),
                      SizedBox(height: 20),
                      CustomTextFormField(
                        labelText: 'Phone',
                        controller: phoneController,
                        prefixIcon: Icons.phone,
                        validator: validatephoneNumber,
                      ),
                      SizedBox(height: 20),
                      CustomTextFormField(
                        labelText: 'Password',
                        controller: passwordController,
                        prefixIcon: Icons.lock,
                        isPassword: true,
                        validator: validatePassword,
                      ),
                      SizedBox(height: 20),
                      CustomTextFormField(
                        labelText: 'Confirm Password',
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
                            );
                          }),
                          Expanded(
                            child: Text(
                              "By creating an account, you agree to our Terms & Conditions.",
                              style: TextStyle(color: Colors.grey),
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
                            "Create account",
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
                    Text("Already have an account? "),
                    GestureDetector(
                      onTap: () {
                        Get.toNamed(Pages.login);
                      },
                      child: Text(
                        "Log in",
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
