import 'dart:io';

import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:lomfu_app/modules/teacher/models/course_model.dart';
import 'package:lomfu_app/API/api_service.dart';
import 'package:lomfu_app/API/api_const.dart';
import 'package:lomfu_app/API/api_exceptions.dart';
import 'package:lomfu_app/modules/home/controllers/home_controller.dart';

class CourseController extends GetxController {
  final APIService _apiService = APIService();
  final courselist = RxList<CourseModel>();
  final loading = false.obs;

  var subjects = Get.find<HomeController>().subjects;
  var selectedSubject;
  var titleEditTextController = TextEditingController();
  var overviewEditTextController = TextEditingController();
  var subjectEditTextController = TextEditingController();
  Rx<File?> courseImage = Rx<File?>(null);

  @override
  void onInit() async {
    super.onInit();
    await fetchCourses();
  }

  Future<void> fetchCourses() async {
    loading(true);
    try {
      final response = await _apiService.get(Endpoints.teachersCourses);
      if (response.statusCode == 200) {
        courselist.clear();
        courselist.value = (response.body as List)
            .map((json) => CourseModel.fromJson(json))
            .toList();
      } else {
        Get.snackbar("Error", "REQUEST BAD");
      }
    } on ApiExceptions catch (e) {
      errorHandler(e);
    } finally {
      loading(false);
    }
  }

  Future<void> addCourse() async {
    try {
      loading(true);
      final photo = courseImage.value == null ? null :MultipartFile(
        courseImage.value,
        filename: courseImage.value!.path.split('/').last,
        contentType: 'image/jpeg',
      );
      final data = FormData({
        APIKeys.courseSubject: selectedSubject,
        APIKeys.courseTitle: titleEditTextController.text,
        APIKeys.courseOverview: overviewEditTextController.text,
        APIKeys.coursePhoto: photo,
      });

      final response =
          await _apiService.post(Endpoints.teachersAddCourse, data);
      if (response.statusCode == 201) {
        Get.snackbar("Success", "Course Added");
        await fetchCourses();
        Get.back();
      } else {
        Get.snackbar("Error", "REQUEST BAD");
      }
    } on ApiExceptions catch (e) {
      errorHandler(e);
    } finally {
      loading(false);
      clearForm();
    }
  }


  void deleteCourse(int id) async {
    try {
      loading(true);
      final response = await _apiService.delete("${Endpoints.teachersDeleteCourse}$id/delete/");
      if (response.statusCode == 204) {
        Get.snackbar("Success", "Course Deleted");
        await fetchCourses();
        Get.back();
      } else {
        Get.snackbar("Error", "REQUEST BAD");
      }
    } on ApiExceptions catch (e) {
      errorHandler(e);
    } finally {
      loading(false);
    }
  } 



  
  void clearForm() {
    titleEditTextController.clear();
    overviewEditTextController.clear();
    subjectEditTextController.clear();
    selectedSubject = subjects.first.slug;
    courseImage.value = null;
  }




}
