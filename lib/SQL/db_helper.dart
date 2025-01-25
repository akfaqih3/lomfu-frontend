import 'package:get/get_state_manager/src/rx_flutter/rx_disposable.dart';

import 'sql_config.dart';
import 'package:sqflite/sqflite.dart';

class DbHelper extends GetxService {
  static Database? _dataBase;


  @override
  void onInit() async {
    super.onInit();
    _dataBase = await SqlConfig.initDataBase();
  }

  Future<Database?> get dataBase async {
    if (_dataBase == null) {
      _dataBase = await SqlConfig.initDataBase();
      return _dataBase;
    } else {
      return _dataBase;
    }
  }

  create(
    String tableName,
    Map<String, Object?> value, {
    String? nullColumnHack,
    ConflictAlgorithm? conflictAlgorithm,
  }) async {
    try {
      Database? db = await dataBase;
      var id = db!.insert(tableName, value);
      return id;
    } catch (e) {
      return -1;
    }
  }

  read(
    String tableName, {
    bool? distinct,
    List<String>? columns,
    String? where,
    List<Object?>? whereArgs,
    String? groupBy,
    String? having,
    String? orderBy,
    int? limit,
    int? offset,
  }) async {
    try {
      Database? db = await dataBase;
      Future<List<Map<String, Object?>>> response = db!.query(
        tableName,
        distinct: distinct,
        columns: columns,
        where: where,
        whereArgs: whereArgs,
        groupBy: groupBy,
        having: having,
        orderBy: orderBy,
        limit: limit,
        offset: offset,
      );
      return response;
    } catch (e) {
      return [];
    }
  }

  update(
    String tableName,
    Map<String, Object?> value, {
    String? where,
    List<Object?>? whereArgs,
    ConflictAlgorithm? conflictAlgorithm,
  }) async {
    Database? db = await dataBase;
    var id = await db!.update(
      tableName,
      value,
      where: where,
      whereArgs: whereArgs,
      conflictAlgorithm: conflictAlgorithm,
    );
    return id;
  }

  delete(
    String tableName, {
    String? where,
    List<Object?>? whereArgs,
  }) async {
    Database? db = await dataBase;
    var id = await db!.delete(
      tableName,
      where: where,
      whereArgs: whereArgs,
    );
    return id;
  }
}
