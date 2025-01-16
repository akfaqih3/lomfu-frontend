import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lomfu_app/config/constants/api_const.dart';
import 'package:lomfu_app/modules/home/controllers/home_controller.dart';
import 'package:lomfu_app/themes/colors.dart';
import 'package:lomfu_app/widgets/custom_app_bar.dart';

class HomePage extends StatelessWidget {
  final HomeController _controller = Get.put(HomeController());
  @override
  Widget build(BuildContext context) {
    final isDarkMode = Get.isDarkMode;
    return Scaffold(
        appBar: AppBar(
            title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text("Home"),
            InkWell(
                onTap: () {
                  _controller.logout();
                },
                child: const Icon(Icons.logout))
          ],
        )),
        body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Obx(() {
              var subjects = _controller.subjects.value;
              return subjects == null
                  ? Text("Subject not found")
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                          for (var subject in subjects)
                            Container(
                              height: 150,
                              child: Card(
                                elevation: 5,
                                color: AppColors.darkBackground,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Image.network(
                                      baseUrl + subject.photo!,
                                      width: 100,
                                      height: 100,
                                    ),
                                    Text(subject.title),
                                  ],
                                ),
                              ),
                            )
                        ]);
            })));
  }
}
