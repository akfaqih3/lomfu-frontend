import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:lomfu_app/config/routes.dart';
import 'package:lomfu_app/modules/onboarding/onboarding_controller.dart';
import 'package:lomfu_app/home.dart';

class AuthMiddleware extends GetMiddleware  {
  @override
  RouteSettings? redirect(String? route) {
 
    if (loginController.accessToken == null) {
      return const RouteSettings(name: Pages.login);
    } else {
      return null;
    }
  }
}

class OnboardingMiddleware extends GetMiddleware {
  @override
  RouteSettings? redirect(String? route) {
    final isFirstOpen = Get.find<OnboardingController>().isFirstOpen;
    if (isFirstOpen) {
      return null;
    } else {
      return RouteSettings(name: Pages.home);
    }
  }
}
