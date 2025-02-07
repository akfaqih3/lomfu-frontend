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
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      appBar: CustomAppBar(),
      bottomNavigationBar: CustomBottomBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
        child: Obx(() {
          var subjects = controller.subjects.value;
          var courses = controller.courses.value;

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // قسم التخصصات
              Text(
                lblSubjects.tr,
                style: Get.textTheme.titleLarge,
              ),
              const SizedBox(height: 20),
              SizedBox(
                height: 180,
                child: subjects == null
                    ? Center(child: Text(lblNoSubjects.tr))
                    : ListView.builder(
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
                                        : controller.isConnected.value
                                            ? Image.network(
                                                baseUrl + subject.photo!,
                                                width: 140,
                                                height: 140,
                                                fit: BoxFit.cover,
                                                errorBuilder: (context, error,
                                                    stackTrace) {
                                                  return Container(
                                                    width: 140,
                                                    height: 140,
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                    ),
                                                    child: Text(
                                                        lblNoPhotoAvailable.tr),
                                                  );
                                                },
                                              )
                                            : Image.memory(
                                                subject.photoBytes!
                                                    .readAsBytesSync(),
                                                width: 140,
                                                height: 140,
                                                fit: BoxFit.cover,
                                                errorBuilder: (context, error,
                                                    stackTrace) {
                                                  return Container(
                                                    width: 140,
                                                    height: 140,
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                    ),
                                                    child: Text(
                                                        lblNoPhotoAvailable.tr),
                                                  );
                                                },
                                              ),
                                  ),
                                  const SizedBox(height: 10),
                                  Text(
                                    subject.title,
                                    style: Get.textTheme.labelLarge,
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
              ),
              const SizedBox(height: 40),

              // قسم الكورسات
              Text(
                lblCourses.tr,
                style: Get.textTheme.titleLarge,
              ),
              const SizedBox(height: 20),
              courses == null
                  ? Center(child: Text(lblNoCourses.tr))
                  : Expanded(
                      child: ListView.builder(
                        itemCount: courses.length,
                        itemBuilder: (context, index) {
                          var course = courses[index];
                          return Card(
                            margin: const EdgeInsets.only(bottom: 15),
                            color: Get.isDarkMode
                                ? AppColors.darkSurface
                                : AppColors.lightSurface,
                            elevation: 3,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(8),
                                    child: course.photo == null
                                        ? Icon(Icons.image_not_supported)
                                        : Image.network(
                                            course.photo!,
                                            width: double.infinity,
                                            height: 150,
                                            fit: BoxFit.cover,
                                            errorBuilder:
                                                (context, error, stackTrace) {
                                              return Container(
                                                width: double.infinity,
                                                height: 150,
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                ),
                                                child: Center(
                                                  child: Text(
                                                      lblNoPhotoAvailable.tr),
                                                ),
                                              );
                                            },
                                          ),
                                  ),
                                  const SizedBox(height: 10),
                                  Text(
                                    course.title,
                                    style: Get.textTheme.titleLarge,
                                  ),
                                  const SizedBox(height: 5),
                                  Text(
                                    course.overview,
                                    style: Get.textTheme.labelMedium,
                                    maxLines: 3,
                                  ),
                                  const SizedBox(height: 10),
                                  Row(
                                    children: [
                                      Icon(Icons.people, size: 16),
                                      const SizedBox(width: 5),
                                      Text(
                                        '${course.totalStudents} ',
                                        style: Get.textTheme.labelSmall,
                                      ),
                                      const SizedBox(width: 15),
                                      Icon(Icons.library_books, size: 16),
                                      const SizedBox(width: 5),
                                      Text(
                                        '${course.totalModules} ',
                                        style: Get.textTheme.labelSmall,
                                      ),
                                    ],
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
