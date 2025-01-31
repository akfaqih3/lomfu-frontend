import 'package:get/get.dart';
import 'package:lomfu_app/config/routes.dart';
import 'package:lomfu_app/helpers/token_storage.dart';
import 'package:lomfu_app/modules/home/controllers/home_controller.dart';
import 'package:lomfu_app/modules/home/models/subject_model.dart';

class OnboardingController extends GetxController {
  final currentPage = 0.obs;

  @override
  void onInit() async {
    super.onInit();
    await Get.find<HomeController>();
  }

  final List<Map<String, String>> onboardingData = [
    {
      "image": "assets/images/svg/onboarding1.svg",
      "title": "Numerous free trial courses",
      "description": "Free courses for you to find your way to learning ",
    },
    {
      "image": "assets/images/svg/onboarding2.svg",
      "title": "Quick and easy learning",
      "description":
          "Easy and fast learning at any time to help you improve various skills",
    },
    {
      "image": "assets/images/svg/onboarding3.svg",
      "title": "Create your own study plan",
      "description":
          "Study according to the study plan, make study more motivated",
    },
  ];
}
