import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lomfu_app/API/api_const.dart';
import 'package:lomfu_app/config/routes.dart';
import 'package:lomfu_app/helpers/localizition/app_langs/keys.dart';
import 'package:lomfu_app/modules/teacher/controller/course_controller.dart';
import 'package:lomfu_app/themes/colors.dart';
import 'package:lomfu_app/widgets/custom_app_bar.dart';
import 'package:lomfu_app/widgets/cutom_text_field.dart';

class CourseListPage extends GetView<CourseController> {


  @override
  Widget build(BuildContext context) {
    final controller = Get.put(CourseController());
    return Scaffold(
      appBar: CustomAppBar(
        title: Text(lblCourses.tr),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              lblMyCourses.tr,
              style: Get.textTheme.titleLarge,
            ),
            const SizedBox(height: 8),
            Expanded(
              child: Obx(() {
                if (controller.loading.value)
                  return const Center(child: CircularProgressIndicator());

                if (controller.courselist.isEmpty)
                  return  Center(child: Text(lblNoCourses.tr));

                return _courseList();
              }),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Navigate to add course page
        },
        child: Icon(
          Icons.add,
          color: Get.isDarkMode ? AppColors.darkText : AppColors.lightText,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  Widget _courseList() {
    return ListView.builder(
      itemCount: controller.courselist.length,
      itemBuilder: (context, index) {
        final course = controller.courselist[index];
        return Card(
          margin: const EdgeInsets.symmetric(vertical: 8),
          color:
              Get.isDarkMode ? AppColors.darkSurface : AppColors.lightSurface,
          child: ListTile(
            leading: course.photo != null
                ? Image.network(
                    "${baseUrl}${course.photo}",
                    width: 50,
                    height: 50,
                    fit: BoxFit.cover,
                  )
                : Icon(
                    Icons.image_not_supported,
                    size: 50,
                  ),
            title: Text(course.title),
            subtitle: Text(course.subject, maxLines: 2),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: Icon(Icons.edit),
                  onPressed: () {
                    // Navigate to edit course page
                  },
                ),
                IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () {
                    // Delete the course
                  },
                ),
              ],
            ),
            onTap: () {
              // Navigate to course details
            },
          ),
        );
      },
    );
  }
}
