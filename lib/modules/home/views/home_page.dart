import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lomfu_app/API/api_const.dart';
import 'package:lomfu_app/helpers/localizition/app_langs/keys.dart';
import 'package:lomfu_app/modules/home/controllers/home_controller.dart';
import 'package:lomfu_app/themes/colors.dart';
import 'package:lomfu_app/widgets/custom_app_bar.dart';
import 'package:lomfu_app/widgets/bottom_navigation_bar.dart';

class HomePage extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      bottomNavigationBar: CustomBottomBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
        child: Obx(() {
          var subjects = controller.subjects.value;
          return subjects == null
              ? Center(child: Text(lblNoSubjects.tr))
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      lblSubjects.tr,
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 20),
                    SizedBox(
                      height: 180,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: subjects.length,
                        itemBuilder: (context, index) {
                          var subject = subjects[index];
                          return Padding(
                            padding: const EdgeInsets.only(right: 15.0),
                            child: Container(
                              margin: const EdgeInsets.only(bottom: 4, top: 4),
                              width: 140,
                              decoration: BoxDecoration(
                                color: Get.isDarkMode
                                    ? AppColors.darkSurface
                                    : AppColors.lightSurface,
                                borderRadius: BorderRadius.circular(12),
                                boxShadow: [
                                  BoxShadow(
                                    color: AppColors.black.withOpacity(0.2),
                                    spreadRadius: 2,
                                    blurRadius: 5,
                                    offset: const Offset(0, 3),
                                  ),
                                ],
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(8),
                                    child: subject.photo == null
                                        ? Icon(Icons.image_not_supported)
                                        : controller.isConnected.value?
                                        Image.network(
                                            baseUrl + subject.photo!,
                                            width: 140,
                                            height: 140,
                                            fit: BoxFit.cover,
                                            errorBuilder:
                                                (context, error, stackTrace) {
                                              return Container(
                                                width: 140,
                                                height: 140,
                                                decoration: BoxDecoration(
                                                  // color: primaryColor,
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                ),
                                                child:
                                                    Text("No image available"),
                                              );
                                            },
                                          ): Image.memory(
                                            subject.photoBytes!.readAsBytesSync(),
                                            width: 140,
                                            height: 140,
                                            fit: BoxFit.cover,
                                            errorBuilder: (context, error,
                                                stackTrace) {
                                              return Container(
                                                width: 140,
                                                height: 140,
                                                decoration: BoxDecoration(
                                                  // color: primaryColor,
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                ),
                                                child:
                                                    Text("No image available"),
                                              );
                                            },
                                          ),
                                  ),
                                  const SizedBox(height: 10),
                                  Text(
                                    subject.title,
                                    style: Get.textTheme.bodyLarge,
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                );
        }),
      ),
    );
  }
}
