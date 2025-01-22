import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';

class LanguageService extends GetxService {
  static const appLangkey = 'appLang';
  final arKey = 'ar';
  final enKey = 'en';

  final appLang = GetStorage().read(appLangkey) ?? Get.locale!.languageCode;

  @override
  void onInit() {
    Get.updateLocale(Locale(appLang));
    super.onInit();
  }

  void changeLanguage(String langKey) async {
    Get.updateLocale(Locale(langKey));
    await GetStorage().write(appLangkey, langKey);
  }
}
