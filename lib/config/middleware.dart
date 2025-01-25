import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:lomfu_app/helpers/token_storage.dart';
import 'package:lomfu_app/config/routes.dart';
import 'package:get_storage/get_storage.dart';
import 'package:lomfu_app/modules/auth/controllers/login_controller.dart';
import 'package:lomfu_app/modules/onboarding/onboarding_controller.dart';

class AuthMiddleware extends GetMiddleware  {
  @override
  RouteSettings? redirect(String? route) {
    final loginServcie = Get.find<LoginController>();
    if (loginServcie.accessToken == null) {
      return const RouteSettings(name: Pages.login);
    } else {
      return RouteSettings(name: route ?? Pages.home);
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
