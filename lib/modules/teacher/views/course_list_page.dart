import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lomfu_app/API/api_const.dart';
import 'package:lomfu_app/config/routes.dart';
import 'package:lomfu_app/helpers/localizition/app_langs/keys.dart';
import 'package:lomfu_app/helpers/network_helper.dart';
import 'package:lomfu_app/modules/home/controllers/home_controller.dart';
import 'package:lomfu_app/modules/teacher/controller/course_controller.dart';
import 'package:lomfu_app/widgets/bottom_navigation_bar.dart';
import 'package:lomfu_app/themes/colors.dart';
import 'package:lomfu_app/widgets/custom_app_bar.dart';
import 'package:lomfu_app/widgets/cutom_text_field.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lomfu_app/modules/teacher/models/course_model.dart';

class CourseListPage extends GetView<CourseController> {
  final controller = Get.put(CourseController());

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
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
                  return Center(child: Text(lblNoCourses.tr));

                return _courseList();
              }),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showAddCourseDialog(null);
        },
        child: Icon(
          Icons.add,
          color: Get.isDarkMode ? AppColors.darkText : AppColors.lightText,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      bottomNavigationBar: CustomBottomBar(),
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
                : course.photoBytes != null
                    ? Image.memory(
                        course.photoBytes!,
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
                    _showAddCourseDialog(course);
                  },
                ),
                IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () {
                    _deleteCourseDialog(course);
                  },
                ),
              ],
            ),
            onTap: () {
              // Get.toNamed(Pages.courseDetails, arguments: {"course": course});
            },
          ),
        );
      },
    );
  }

  void _showAddCourseDialog(CourseModel? course) {
    final _formKey = GlobalKey<FormState>();

    if (course != null) {
      controller.titleEditTextController.text = course.title;
      controller.overviewEditTextController.text = course.overview;
      controller.selectedSubject = controller.subjects
          .firstWhereOrNull((element) => element.title == course.subject)
          ?.slug;
    }
    Future<void> _pickImage() async {
      final pickedFile =
          await ImagePicker().pickImage(source: ImageSource.gallery);
      if (pickedFile != null) {
        controller.courseImage.value = File(pickedFile.path);
      }
    }

    Get.defaultDialog(
      title: (course == null) ? lblNewCourse.tr : lblEditCourse.tr,
      content: Obx(() {
        final subjects = controller.subjects;

        return SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                DropdownButtonFormField<String>(
                  value: subjects.first.slug,
                  items: subjects
                      .map((e) => DropdownMenuItem(
                            value: e.slug,
                            child: Text(e.title),
                          ))
                      .toList(),
                  onChanged: (value) {
                    controller.selectedSubject = value!;
                  },
                  decoration: InputDecoration(labelText: hntSelectSubject.tr),
                  validator: (value) => value == null || value.isEmpty
                      ? hntPleaseSelectASubject.tr
                      : null,
                ),
                SizedBox(height: 10),
                CustomTextFormField(
                  controller: controller.titleEditTextController,
                ),
                SizedBox(height: 10),
                CustomTextFormField(
                  controller: controller.overviewEditTextController,
                ),
                SizedBox(height: 10),
                MaterialButton(
                  onPressed: _pickImage,
                  child: Text(
                      (course == null) ? lblchooseCoursePhoto.tr : lblEditPhoto.tr),
                ),
                Obx(() {
                  return controller.courseImage.value != null
                      ? Image.file(
                          controller.courseImage.value!,
                          height: 100,
                          width: 100,
                          fit: BoxFit.cover,
                        )
                      : course != null && course.photo != null
                          ? Image.network(
                              key: ValueKey(course.photo),
                              "${baseUrl + course.photo!}",
                              height: 100,
                              width: 100,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) {
                                return Container(
                                  width: 100,
                                  height: 100,
                                  decoration: BoxDecoration(
                                    // color: primaryColor,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Text(lblNoPhotoAvailable.tr),
                                );
                              },
                            )
                          : Text(lblNoPhotoSelected.tr);
                }),
              ],
            ),
          ),
        );
      }),
      textCancel: btnCancel.tr,
      textConfirm: (course == null) ? btnAdd.tr : btnUpdate.tr,
      onCancel: () {},
      onConfirm: () {
        if (_formKey.currentState!.validate()) {
          _formKey.currentState!.save();
          if (controller.selectedSubject == null) {
            Get.snackbar(lblError.tr, hntPleaseSelectASubject.tr);
            return;
          }

          if (course == null) {
            controller.addCourse();
          } else {
            controller.updateCourse(course.localId, course.serverId);
          }
          Get.back();
        }
      },
    );
  }

  _deleteCourseDialog(CourseModel course) {
    Get.defaultDialog(
        title: lblDeleteCourse.tr,
        content: Text(lblAreYouSureYouWantToDeleteThisCourse.tr),
        actions: [
          ElevatedButton(
            child: Text(btnYes.tr),
            onPressed: () {
              controller.deleteCourse(course.localId, course.serverId);
              Get.back<bool>(result: true);
            },
          ),
          ElevatedButton(
            child: Text(btnNo.tr),
            onPressed: () {
              Get.back<bool>(result: false);
            },
          ),
        ]);
  }
}
