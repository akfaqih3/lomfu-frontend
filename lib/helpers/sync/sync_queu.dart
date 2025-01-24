import 'package:get/get.dart';
import 'package:lomfu_app/helpers/network_helper.dart';
import 'package:lomfu_app/helpers/SQL/sql_consts.dart';
import 'package:lomfu_app/helpers/SQL/db_helper.dart';
import 'package:lomfu_app/modules/teacher/models/course_model.dart';
import 'package:lomfu_app/modules/teacher/services/api_service.dart';
import 'package:lomfu_app/API/api_helper.dart';

//this class will be used to sync data from local to server by reading sync queue table

class SyncQueu extends GetxService {
  final DbHelper _dbHelper = DbHelper();
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
        final dataMap = data[SqlKeys.syncQueueData];
        await _processSyncQueueItem(data[SqlKeys.syncQueueID], type, dataMap);
      }
      Get.snackbar("Success", "Data synced");
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
          await _createCourse(dataMap);
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
    } catch (e) {
      print(e);
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
    return _apiService.updateCourse(
      dataMap[SqlKeys.courseServerID],
      dataMap[SqlKeys.courseSubject],
      dataMap[SqlKeys.courseTitle],
      dataMap[SqlKeys.courseOverview],
      dataMap[SqlKeys.coursePhoto],
    );
  }

  Future<CourseModel> _createCourse(dataMap) {
    return _apiService.addCourse(
      dataMap[SqlKeys.courseSubject],
      dataMap[SqlKeys.courseTitle],
      dataMap[SqlKeys.courseOverview],
      dataMap[SqlKeys.coursePhoto],
    );
  }
}
