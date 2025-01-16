import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lomfu_app/themes/colors.dart';
import 'package:lomfu_app/modules/auth/controllers/confirm_email_controller.dart';

class ConfirmEmailPage extends StatelessWidget {
  final ConfirmEmailController controller = ConfirmEmailController();

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Get.isDarkMode;

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
            padding:
                const EdgeInsets.only(bottom: 100.0, left: 10.0, right: 10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // النص الرئيسي
                Text(
                  "Verify Email",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color:
                        isDarkMode ? AppColors.darkText : AppColors.lightText,
                  ),
                ),
                SizedBox(height: 10),
                // النص التوضيحي
                Text(
                  "Code is sent to ${controller.email}",
                  style: TextStyle(
                    fontSize: 16,
                    color:
                        isDarkMode ? AppColors.darkText : AppColors.lightText,
                  ),
                ),
                SizedBox(height: 30),
                // حقول إدخال الكود
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: List.generate(
                    6,
                    (index) => SizedBox(
                      width: 50,
                      child: TextField(
                        focusNode: controller.focusNodes[index],
                        controller: controller.textControllers[index],
                        textAlign: TextAlign.center,
                        keyboardType: TextInputType.number,
                        maxLength: 1,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: isDarkMode
                              ? AppColors.darkText
                              : AppColors.darkText,
                        ),
                        decoration: InputDecoration(
                          counterText: "",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide(
                                color: isDarkMode
                                    ? AppColors.darkText
                                    : AppColors.primary),
                          ),
                        ),
                        onChanged: (value) =>
                            controller.handleInputChange(value, index),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Don't recieve code? "),
                    Obx(() {
                      if (controller.resendAfter.value > 0) {
                        return Text(
                          "${controller.resendAfter.value}",
                          style: TextStyle(
                              color: AppColors.primary,
                              fontWeight: FontWeight.bold),
                        );
                      }

                      return controller.isResending.value
                          ? const CircularProgressIndicator(
                              color: AppColors.primary,
                            )
                          : GestureDetector(
                              onTap: () {
                                controller.resendOTP();
                              },
                              child: const Text(
                                "Resend",
                                style: TextStyle(
                                    color: Colors.blue,
                                    fontWeight: FontWeight.bold),
                              ),
                            );
                    })
                  ],
                ),
                const SizedBox(height: 20),
                Center(
                  child: Obx(() {
                    return controller.isLoading.value
                        ? const CircularProgressIndicator(
                            color: AppColors.primary,
                          )
                        : ElevatedButton(
                            onPressed: () {
                              controller.verifyAccount();
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.primary,
                              padding: EdgeInsets.symmetric(
                                  vertical: 15, horizontal: 50),
                            ),
                            child: Text(
                              "Verify Account",
                              style: TextStyle(color: AppColors.lightText),
                            ),
                          );
                  }),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
