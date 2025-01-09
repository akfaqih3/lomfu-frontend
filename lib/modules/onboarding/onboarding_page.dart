import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:lomfu_app/themes/colors.dart';
import 'package:lomfu_app/config/routes.dart';

class OnboardingPage extends StatelessWidget {
  final PageController _pageController = PageController();
  final currentPage = 0.obs;

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

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Get.isDarkMode;
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: PageView.builder(
              controller: _pageController,
              onPageChanged: (index) {
                currentPage.value = index;
              },
              itemCount: onboardingData.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset(onboardingData[index]["image"]!),
                      SizedBox(height: 20),
                      Text(
                        onboardingData[index]["title"]!,
                        style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: isDarkMode
                                ? AppColors.lightText
                                : AppColors.primary),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 10),
                      Text(
                        onboardingData[index]["description"]!,
                        softWrap: true,
                        style: TextStyle(fontSize: 16, color: Colors.grey),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 70),
                      Obx(() {
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: List.generate(
                            onboardingData.length,
                            (index) => AnimatedContainer(
                              duration: Duration(milliseconds: 300),
                              margin: EdgeInsets.symmetric(horizontal: 4),
                              width: currentPage.value == index ? 12 : 8,
                              height: 8,
                              decoration: BoxDecoration(
                                color: currentPage.value == index
                                    ? Colors.blue
                                    : Colors.grey,
                                borderRadius: BorderRadius.circular(4),
                              ),
                            ),
                          ),
                        );
                      }),
                    ],
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 20),
            child: Obx(() {
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                    onPressed: () {
                      Get.offNamed(
                          Pages.login); // الانتقال مباشرة إلى شاشة تسجيل الدخول
                    },
                    child: Text("Skip"),
                  ),
                  ElevatedButton(
                    onPressed: currentPage.value == onboardingData.length - 1
                        ? () {
                            Get.offNamed(Pages
                                .login); // إذا كانت آخر صفحة، الانتقال إلى تسجيل الدخول
                          }
                        : () {
                            _pageController.nextPage(
                              duration: Duration(milliseconds: 300),
                              curve: Curves.easeInOut,
                            );
                          },
                    child: Text(currentPage.value == onboardingData.length - 1
                        ? "Get Started"
                        : "Next"),
                  ),
                ],
              );
            }),
          ),
        ],
      ),
    );
  }
}
