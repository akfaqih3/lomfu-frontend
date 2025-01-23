import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';

class ThemeService extends GetxService {
  bool isDark = false;

  @override
  void onInit() async {
    super.onInit();
    getMode();
  }

  void getMode() async {
    isDark = await GetStorage().read("isDark") ?? Get.isDarkMode;
    Get.changeThemeMode(isDark ? ThemeMode.dark : ThemeMode.light);
  }

  Future<void> toggleMode() async {
    await GetStorage().write("isDark", !Get.isDarkMode);
    Get.changeThemeMode(Get.isDarkMode ? ThemeMode.light : ThemeMode.dark);
  }
}
