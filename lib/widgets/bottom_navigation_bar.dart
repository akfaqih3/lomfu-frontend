import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lomfu_app/helpers/localizition/app_langs/keys.dart';
import 'package:lomfu_app/themes/colors.dart';
import 'package:lomfu_app/config/routes.dart';

class CustomBottomBar extends StatelessWidget {
  const CustomBottomBar({super.key});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items:  [
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: lblHome.tr,
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.library_books),
          label: lblLearning.tr,
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person),
          label: lblProfile.tr,
        ),
      ],

      onTap: (value) {
        switch (value) {
          case 0:
            Get.offNamed(Pages.home);
            break;
          case 1:
            Get.offNamed(Pages.courseList);
            break;
          case 2:
            // Get.offNamed(Pages.profile);
            break;
        }
      },
    );
  }
}
