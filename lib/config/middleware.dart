import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:lomfu_app/helpers/token_storage.dart';
import 'package:lomfu_app/config/routes.dart';

class AuthMiddleware extends GetMiddleware {
  @override
  redirect(String? route) async {
    final accessToken = await TokenStorage.getAccessToken();
    if (accessToken == null) {
      Get.offAllNamed(Pages.login);
    } else {
      Get.offAllNamed(Pages.courseList);
    }
  }
}
