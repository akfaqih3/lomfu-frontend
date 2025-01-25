import 'dart:convert';
import 'dart:io';

import 'package:get/get.dart';
import 'package:lomfu_app/SQL/db_helper.dart';
import 'package:lomfu_app/SQL/sql_consts.dart';
import 'package:lomfu_app/modules/teacher/models/course_model.dart';

class SQLService {
  final DbHelper _dbHelper =Get.find<DbHelper>();

  Future<List<CourseModel>> getCourses() async {
    final response = await _dbHelper.read(SqlKeys.courseTable);
    return List.generate(
        response.length, (index) => CourseModel.fromSql(response[index]));
  }

  Future<int> createCourse(String subject, String title, String overview,
      num? serverId, num? ownerId, File? photo) async {
    final photoBytes = photo == null ? null : await photo.readAsBytes();

    final id = await _dbHelper.create(SqlKeys.courseTable, {
      SqlKeys.courseServerID: serverId,
      SqlKeys.courseOwnerID: ownerId,
      SqlKeys.courseSubject: subject,
      SqlKeys.courseTitle: title,
      SqlKeys.courseOverview: overview,
      SqlKeys.coursePhoto: photoBytes,
      SqlKeys.courseCreatedAt: DateTime.now().toString(),
    });

    if (serverId == 0) {
      await _dbHelper.create(SqlKeys.syncQueueTable, {
        SqlKeys.syncQueueType: SqlKeys.syncQueueTypeAddCourse,
        SqlKeys.syncQueueData: jsonEncode({
          SqlKeys.courseLocalID: id,
          SqlKeys.courseSubject: subject,
          SqlKeys.courseTitle: title,
          SqlKeys.courseOverview: overview,
          SqlKeys.coursePhoto: photo != null ? photo.path : null,
        }),
        SqlKeys.syncQueueCreatedAt: DateTime.now().toString(),
      });
    }

    return id;
  }

  Future<void> updateCourse(num? localId, num? serverID, String subject,
      String title, String overview, bool isUpdated, File? photo) async {
    final photoBytes = photo == null ? null : await photo.readAsBytes();
    await _dbHelper.update(
      SqlKeys.courseTable,
      {
        SqlKeys.courseSubject: subject,
        SqlKeys.courseTitle: title,
        SqlKeys.courseOverview: overview,
        if (photoBytes != null) SqlKeys.coursePhoto: photoBytes,
        SqlKeys.courseCreatedAt: DateTime.now().toString(),
      },
      where: "${SqlKeys.courseLocalID} = $localId",
    );

    if (!isUpdated && serverID != 0) {
      await _dbHelper.create(SqlKeys.syncQueueTable, {
        SqlKeys.syncQueueType: SqlKeys.syncQueueTypeUpdateCourse,
        SqlKeys.syncQueueData: jsonEncode({
          SqlKeys.courseLocalID: localId,
          SqlKeys.courseOwnerID: serverID ?? 0.0,
          SqlKeys.courseServerID: serverID,
          SqlKeys.courseSubject: subject,
          SqlKeys.courseTitle: title,
          SqlKeys.courseOverview: overview,
          if (photo != null) SqlKeys.coursePhoto: photo.path,
        }),
        SqlKeys.courseCreatedAt: DateTime.now().toString()
      });
    }
  }

  Future<void> deleteCourse(num? id, num? serverID, bool isDeleted) async {
    await _dbHelper.delete(
      SqlKeys.courseTable,
      where: "${SqlKeys.courseLocalID} = $id",
    );
    if (!isDeleted && serverID != 0) {
      await _dbHelper.create(SqlKeys.syncQueueTable, {
        SqlKeys.syncQueueType: SqlKeys.syncQueueTypeDeleteCourse,
        SqlKeys.syncQueueData: jsonEncode({
          SqlKeys.courseServerID: serverID,
        }),
        SqlKeys.syncQueueCreatedAt: DateTime.now().toString(),
      });
    }
  }
}
