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

  static const String subjectSlug = "slug";
  static const String subjectTitle = "title";
  static const String subjectPhoto = "photo";
  static const String subjectCoursesTotal = "courses_total";

  static const String courseTable = "courses";

  static const String courseID = "id";
  static const String courseTitle = "title";
  static const String courseSubject = "subject";
  static const String courseOverview = "overview";
  static const String coursePhoto = "photo";
  static const String courseCreatedAt = "created_at";

  static const String AsyncQueueTable = "async_queue";
  static const String AsyncQueueID = "id";
  static const String AsyncQueueType = "type";
  static const String AsyncQueueData = "data";
  static const String AsyncQueueCreatedAt = "created_at";

  // async queue types
  static const String asyncQueueTypeAddCourse = "add";
  static const String asyncQueueTypeUpdateCourse = "update";
  static const String asyncQueueTypeDeleteCourse = "delete";

  static const String createCourseTable =
      "CREATE TABLE $courseTable ($courseID INTEGER PRIMARY KEY, $courseTitle TEXT, $courseSubject TEXT, $courseOverview TEXT, $coursePhoto BLOB NULL, $courseCreatedAt TEXT)";

  static const String createAsyncQueueTable =
      "CREATE TABLE $AsyncQueueTable ($AsyncQueueID INTEGER PRIMARY KEY, $AsyncQueueType TEXT, $AsyncQueueData JSON, $AsyncQueueCreatedAt DATETIME)";
}
