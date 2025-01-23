import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:lomfu_app/helpers/token_storage.dart';
import 'package:lomfu_app/config/routes.dart';
import 'package:get_storage/get_storage.dart';

class AuthMiddleware extends GetMiddleware {
  @override
  redirect(String? route) async {
    final isFirstOpen = await GetStorage().read('isFirstOpen') ?? true;
    if (isFirstOpen) {
      GetStorage().write('isFirstOpen', false);
      return Pages.onboarding;
    } else {
      final accessToken = await TokenStorage.getAccessToken();
      if (accessToken == null) {
        Get.offAllNamed(Pages.login);
      } else {
        Get.offAllNamed(Pages.courseList);
      }
    }
  }
}
