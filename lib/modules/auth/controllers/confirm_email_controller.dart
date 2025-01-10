import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lomfu_app/API/api_service.dart';
import 'package:lomfu_app/config/constants/api_const.dart';
import 'package:lomfu_app/config/routes.dart';
import 'package:lomfu_app/helpers/token_storage.dart';
import 'dart:async';

class ConfirmEmailController extends GetxController {
  final APIService _apiService = APIService();
  final List<TextEditingController> textControllers =
      List.generate(6, (index) => TextEditingController());
  final List<FocusNode> focusNodes = List.generate(6, (index) => FocusNode());

  final isLoading = false.obs;
  final isResending = false.obs;
  final resend_after = 0.obs;

  String? email;

  @override
  void onInit() {
    super.onInit();
    email = Get.arguments;
  }

  void handleInputChange(String value, int index) {
    if (value.isNotEmpty && index < 6) {
      focusNodes[index + 1].requestFocus();
    } else if (value.isEmpty && index > 0) {
      focusNodes[index - 1].requestFocus();
    }
  }

  String getEnteredCode() {
    return textControllers.map((controller) => controller.text).join();
  }

  void verifyAccount() async {
    try {
      isLoading(true);
      var data = {"email": email, "otp": getEnteredCode()};
      final response = await _apiService.post(Endpoints.verifyEmail, data);
      if (response.statusCode == 200) {
        Get.snackbar("Success", response.body["message"]);
        await TokenStorage.saveToken(
            response.body["access"], response.body["refresh"]);
        Get.offAllNamed(Pages.home);
      } else {
        Get.snackbar("Error", "Account Verification Failed");
      }
    } catch (e) {
      Get.snackbar("Error", "Account Verification Failed");
    } finally {
      isLoading(false);
    }
  }

  var messages = {"has already been verified."};

  void resendOTP() async {
    try {
      isResending(true);
      var data = {"email": email};
      final response = await _apiService.post(Endpoints.resendOTP, data);
      if (response.statusCode == 200) {
        Get.snackbar("Success", response.body["message"]);
        timerToResend(60);
      } else {
        if (response.statusCode == 400) {
          Get.snackbar("Error", response.body);
          Get.offAllNamed(Pages.login);
        }
        Get.snackbar("Error", response.body["message"]);
      }
    } catch (e) {
      Get.snackbar("Error", "Account Verification Failed");
    }
  }

  void timerToResend(int seconds) {
    resend_after(seconds);
    Timer.periodic(Duration(seconds: 1), (timer) {
      if (resend_after.value == 0) {
        timer.cancel();
        isResending(false);
      }
      resend_after(resend_after.value - 1);
    });
  }

  @override
  void onClose() {
    for (var node in focusNodes) {
      node.dispose();
    }
    for (var controller in textControllers) {
      controller.dispose();
    }
    super.onClose();
  }
}
