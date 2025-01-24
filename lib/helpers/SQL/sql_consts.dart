class SqlKeys {
  static const String dbName = "lomfu.db";
  static const int dbVersion = 1;

  static const String userTable = "users";

  static const String userID = "id";
  static const String userName = "name";
  static const String userEmail = "email";
  static const String userPassword = "password";
  static const String userRole = "role";

  static const String subjectTable = "subjects";

  static const String subjectId = "id";
  static const String subjectSlug = "slug";
  static const String subjectTitle = "title";
  static const String subjectPhoto = "photo";
  static const String subjectCoursesTotal = "courses_total";

  static const String courseTable = "courses";

  static const String courseLocalID = "local_id";
  static const String courseServerID = "server_id";
  static const String courseOwnerID = "owner_id";
  static const String courseTitle = "title";
  static const String courseSubject = "subject";
  static const String courseOverview = "overview";
  static const String coursePhoto = "photo";
  static const String courseCreatedAt = "created_at";

  static const String syncQueueTable = "Sync_queue";
  static const String syncQueueID = "id";
  static const String syncQueueType = "type";
  static const String syncQueueData = "data";
  static const String syncQueueCreatedAt = "created_at";

  // async queue types
  static const String syncQueueTypeAddCourse = "add";
  static const String syncQueueTypeUpdateCourse = "update";
  static const String syncQueueTypeDeleteCourse = "delete";

  static const String createCourseTable =
      "CREATE TABLE $courseTable ($courseLocalID INTEGER PRIMARY KEY, $courseServerID INTEGER NULL, $courseOwnerID INTEGER NULL, $courseTitle TEXT, $courseSubject TEXT, $courseOverview TEXT, $coursePhoto BLOB, $courseCreatedAt TEXT)";

  static const String createSubjectTable =
      "CREATE TABLE $subjectTable ($subjectId INTEGER PRIMARY KEY,  $subjectTitle TEXT, $subjectSlug TEXT, $subjectCoursesTotal INTEGER)";

  static const String createAsyncQueueTable =
      "CREATE TABLE $syncQueueTable ($syncQueueID INTEGER PRIMARY KEY, $syncQueueType TEXT, $syncQueueData TEXT, $syncQueueCreatedAt TEXT)";
}
