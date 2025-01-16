import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:lomfu_app/themes/colors.dart';
import 'package:lomfu_app/config/routes.dart';
import 'package:lomfu_app/modules/onboarding/onboarding_controller.dart';
import 'package:lomfu_app/themes/app_theme.dart';

class OnboardingPage extends StatelessWidget {
  final PageController _pageController = PageController();
  final _controller = Get.put(OnboardingController());

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Get.isDarkMode;
    final currentPage = _controller.currentPage;
    final onboardingData = _controller.onboardingData;

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
                      Get.offNamed(Pages.login);
                    },
                    child: Text("Skip"),
                  ),
                  ElevatedButton(
                    onPressed: currentPage.value == onboardingData.length - 1
                        ? () {
                            Get.offNamed(Pages.login);
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
