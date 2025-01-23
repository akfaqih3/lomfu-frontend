import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:lomfu_app/helpers/SQL/db_helper.dart';
import 'package:lomfu_app/helpers/SQL/sql_consts.dart';
import 'package:lomfu_app/API/api_const.dart';
import 'package:lomfu_app/API/api_helper.dart';
import 'package:lomfu_app/helpers/network_helper.dart';
import 'package:lomfu_app/modules/teacher/services/api_service.dart';

class AsyncQueue {
  final DbHelper _dbHelper = DbHelper();
  final APIService _apiService = APIService();

  Future<void> addCourse(String subject, String title, String overview,
      File? photo) async {
    if (await NetworkHelper.isConnected()) {
      
      await _apiService.addCourse(
        subject,
        title,
        overview,
        photo,
      );
    } else {
      await _dbHelper.create(SqlKeys.AsyncQueueTable, {
        SqlKeys.AsyncQueueType: SqlKeys.asyncQueueTypeAddCourse,
        SqlKeys.AsyncQueueData: jsonEncode({
          APIKeys.courseSubject: subject,
          APIKeys.courseTitle: title,
          APIKeys.courseOverview: overview,
          APIKeys.coursePhoto: photo!=null?photo.path:null,
        }),
        SqlKeys.AsyncQueueCreatedAt: DateTime.now(),
      });
    }
  }

  Future<void> updateCourse(int id, String subject, String title,
      String overview, File? photo) async {
    if (await NetworkHelper.isConnected()) {
      await _apiService.updateCourse(
        id,
        subject,
        title,
        overview,
        photo,
      );
    } else {
      await _dbHelper.create(SqlKeys.AsyncQueueTable, {
        SqlKeys.AsyncQueueType: SqlKeys.asyncQueueTypeUpdateCourse,
        SqlKeys.AsyncQueueData: jsonEncode({
          APIKeys.courseSubject: subject,
          APIKeys.courseTitle: title,
          APIKeys.courseOverview: overview,
          APIKeys.coursePhoto: photo!=null?photo.path:null,
        }),
        SqlKeys.AsyncQueueCreatedAt: DateTime.now(),
      });
    }
  }

  Future<void> deleteCourse(int id) async {
    if (await NetworkHelper.isConnected()) {
      await _apiService.deleteCourse(id);
    } else {
      await _dbHelper.create(SqlKeys.AsyncQueueTable, {
        SqlKeys.AsyncQueueType: SqlKeys.asyncQueueTypeDeleteCourse,
        SqlKeys.AsyncQueueData: jsonEncode({APIKeys.courseId: id}),
        SqlKeys.AsyncQueueCreatedAt: DateTime.now(),
      });
    }
  }



}
