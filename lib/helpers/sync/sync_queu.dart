import 'dart:convert';
import 'dart:io';

import 'package:get/get.dart';
import 'package:lomfu_app/API/api_exceptions.dart';
import 'package:lomfu_app/helpers/network_helper.dart';
import 'package:lomfu_app/SQL/sql_consts.dart';
import 'package:lomfu_app/SQL/db_helper.dart';
import 'package:lomfu_app/modules/teacher/models/course_model.dart';
import 'package:lomfu_app/modules/teacher/services/api_service.dart';
import 'package:lomfu_app/API/api_helper.dart';

//this class will be used to sync data from local to server by reading sync queue table

class SyncQueu extends GetxService {
  final DbHelper _dbHelper = Get.find<DbHelper>();
  final APIService _apiService = APIService();

  @override
  void onInit() async {
    super.onInit();
    if (await NetworkHelper.isConnected()) {
      syncData();
    }
  }

  Future<dynamic> fetchSyncQueue() async {
    try {
      final response = await _dbHelper.read(SqlKeys.syncQueueTable);
      return response;
    } catch (e) {
      Get.snackbar("Error", "Something went wrong");
      print(e);
    }
  }

  //this function will be used to sync data from local to server from sync queue table
  Future<void> syncData() async {
    try {
      final response = await fetchSyncQueue();

      for (var data in response) {
        final type = data[SqlKeys.syncQueueType];
        final dataMap = jsonDecode(data[SqlKeys.syncQueueData]);
        await _processSyncQueueItem(data[SqlKeys.syncQueueID], type, dataMap);
      }
      Get.snackbar("Success", "Data synced!!!");
    } catch (e) {
      Get.snackbar("Error", "Something went wrong");
      print(e);
    } finally {}
  }

  Future<void> _processSyncQueueItem(
      int id, String type, Map<String, dynamic> dataMap) async {
    try {
      switch (type) {
        case SqlKeys.syncQueueTypeAddCourse:
          final response = await _createCourse(dataMap);
          await _dbHelper.update(
              SqlKeys.courseTable,
              {
                SqlKeys.courseServerID: response.serverId,
              },
              where:
                  "${SqlKeys.courseLocalID} = ${dataMap[SqlKeys.courseLocalID]}");
          break;
        case SqlKeys.syncQueueTypeUpdateCourse:
          await _updateCourse(dataMap);
          break;
        case SqlKeys.syncQueueTypeDeleteCourse:
          await _deleteCourse(dataMap);
          break;
        default:
          Get.snackbar("Error", "Unknown sync type");
          return;
      }
      // If successful, delete the item from the sync queue
      await _deleteSyncQueueItem(id);
    } on ApiExceptions catch (e) {
      print(e.error.message);
      Get.snackbar("Error", "Failed to process sync queue item");
    }
  }

  _deleteSyncQueueItem(int id) {
    _dbHelper.delete(
      SqlKeys.syncQueueTable,
      where: "${SqlKeys.syncQueueID} = $id",
    );
  }

  Future<void> _deleteCourse(dataMap) =>
      _apiService.deleteCourse(dataMap[SqlKeys.courseServerID]);

  Future<void> _updateCourse(dataMap) {
    // get file from path
    final photo = dataMap[SqlKeys.coursePhoto] == null
        ? null
        : File(dataMap[SqlKeys.coursePhoto]);
    return _apiService.updateCourse(
      dataMap[SqlKeys.courseServerID],
      dataMap[SqlKeys.courseSubject],
      dataMap[SqlKeys.courseTitle],
      dataMap[SqlKeys.courseOverview],
      photo,
    );
  }

  Future<CourseModel> _createCourse(dataMap) {
    final photo = dataMap[SqlKeys.coursePhoto] == null
        ? null
        : File(dataMap[SqlKeys.coursePhoto]);
    return _apiService.addCourse(
      dataMap[SqlKeys.courseSubject],
      dataMap[SqlKeys.courseTitle],
      dataMap[SqlKeys.courseOverview],
      photo,
    );
  }
}
