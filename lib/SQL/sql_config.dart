import 'package:sqflite/sqflite.dart';

import 'sql_consts.dart';
import 'package:path/path.dart';

class SqlConfig {
  static Future<Database> initDataBase() async {
    String dbPath = join(await getDatabasesPath(), SqlKeys.dbName);
    final db = await openDatabase(dbPath,
        version: SqlKeys.dbVersion, onCreate: _onCreate);
    return db;
  }

  static Future _onCreate(Database db, int version) async {
    await db.execute(SqlKeys.createCourseTable);
    await db.execute(SqlKeys.createAsyncQueueTable);
    await db.execute(SqlKeys.createSubjectTable);
    print("Database created");
  }
}
