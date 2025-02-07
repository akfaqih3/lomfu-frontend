import 'dart:io';

import 'package:get/get.dart';
import 'package:get/get_connect/http/src/multipart/form_data.dart';
import 'package:lomfu_app/API/api_helper.dart';
import 'package:lomfu_app/API/api_const.dart';
import 'package:lomfu_app/modules/teacher/models/course_model.dart';

class APIService {
  final APIHelper _apiHelper = Get.find<APIHelper>();

  Future<List<CourseModel>> getCourses() async {
    final response = await _apiHelper.get(Endpoints.teachersCourses);
    if (response.statusCode == 200) {
      return (response.body as List)
          .map((json) => CourseModel.fromJson(json))
          .toList();
    } else {
      throw Exception("REQUEST BAD");
    }
  }

  Future<CourseModel> addCourse(
    String subject,
    String title,
    String overview,
    File? photo,
  ) async {

    final MultipartFile? photoMultipart = photo == null ? null : MultipartFile(
      photo,
      filename: photo.path.split('/').last,
      contentType: 'image/jpeg',
    );
    
    final data = FormData({
      APIKeys.courseSubject: subject,
      APIKeys.courseTitle: title,
      APIKeys.courseOverview: overview,
      APIKeys.coursePhoto: photoMultipart,
    });
    final response = await _apiHelper.post(Endpoints.teachersAddCourse, data);
    if (response.statusCode == 201) {
      return CourseModel.fromJson(response.body);
    } else {
      throw Exception("REQUEST BAD");
    }
  }

  Future<void> updateCourse(int id,String subject,String title,String overview,File? photo) async {

    final MultipartFile? photoMultipart = photo == null ? null : MultipartFile(
      photo,
      filename: photo.path.split('/').last,
      contentType: 'image/jpeg',
    );
    final data = FormData({
      APIKeys.courseSubject: subject,
      APIKeys.courseTitle: title,
      APIKeys.courseOverview: overview,
      APIKeys.coursePhoto: photoMultipart,
    });
    final response = await _apiHelper.put(
        "${Endpoints.teachersUpdateCourse}$id/update/", data);
    if (response.statusCode == 200) {
      return;
    } else {
      throw Exception("REQUEST BAD");
    }
  }

  Future<void> deleteCourse(int id) async {
    final response = await _apiHelper
        .delete("${Endpoints.teachersDeleteCourse}$id/delete/");
    if (response.statusCode == 204) {
      return;
    } else {
      throw Exception("REQUEST BAD");
    }
  }
}


