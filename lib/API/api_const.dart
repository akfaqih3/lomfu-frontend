
const String baseUrl = 'https://lomfu.pythonanywhere.com/';

const String apiKey = 'api/';

const String version = 'v1/';

const int timeout = 5000;

const Map<String, String> apps = {
  'accounts': 'accounts/',
  'teachers': 'teachers/',
  'courses': 'courses/',
};

class Endpoints {
  //general endpoints
  static String refreshToken =
      "$apiKey$version${apps['accounts']}token/refresh/";

  //accounts endpoints
  static String login = "$apiKey$version${apps['accounts']}login/";
  static String logout = "$apiKey$version${apps['accounts']}logout/";
  static String register = "$apiKey$version${apps['accounts']}register/";
  static String verifyEmail = "$apiKey$version${apps['accounts']}otp-verify/";
  static String resendOTP = "$apiKey$version${apps['accounts']}otp-send/";
  static String forgotPassword =
      "$apiKey$version${apps['accounts']}password-reset/";
  static String resetPassword =
      "$apiKey$version${apps['accounts']}password-reset/confirm/";

  static String googleLogin = "$apiKey$version${apps['accounts']}google/login/";

  //teachers endpoints
  static String teachersCourses = "$apiKey$version${apps['teachers']}courses/";
  static String teachersAddCourse =
      "$apiKey$version${apps['teachers']}courses/create/";
  static String teachersUpdateCourse =
      "$apiKey$version${apps['teachers']}courses/";
  static String teachersDeleteCourse =
      "$apiKey$version${apps['teachers']}courses/";

  //Courses endpoints
  static String subjects = "$apiKey$version${apps['courses']}subjects/";
  static String courses = "$apiKey$version${apps['courses']}";

  static String clientId =
      '86621443946-gr4jhb99qbtkha6ibqdqstt3seepdlqf.apps.googleusercontent.com';
  static String redirectUri =
      'https://lomfu.pythonanywhere.com/api/v1/accounts/google/login/';
  static String scope = 'email profile';
  static String responseType = 'code';

//   static const String uri ="https://accounts.google.com/o/oauth2/auth?client_id=86621443946-gr4jhb99qbtkha6ibqdqstt3seepdlqf.apps.googleusercontent.com&redirect_uri=https://lomfu.pythonanywhere.com/api/v1/accounts/google/login/&scope=email profile&response_type=code";

  static String get createAuthorizationUrl {
    return 'https://accounts.google.com/o/oauth2/auth?'
        'client_id=$clientId&'
        'redirect_uri=$redirectUri&'
        'scope=$scope&'
        'response_type=$responseType';
  }
}

class APIKeys {
  static const String token = 'token';
  static const String accessToken = 'access';
  static const String refreshToken = 'refresh';
  static const String tokenType = 'Bearer';

  static const String detail = 'detail';
  static const String message = 'message';
  static const String results = 'results';
  static const String status = 'status';
  static const String errors = 'errors';

  //courses endpoints paramskeys
  static const String index = 'index';
  static const String size = 'size';
  static const String ordering = 'ordering';
  static const String search = 'search';
  static const String owner__name = 'owner__name';
  static const String subject__slug = 'subject__slug';

  // error messages
  static const String invalidToken = 'Given token not valid for any token type';

  static const String name = 'name';
  static const String email = 'email';
  static const String role = 'role';
  static const String phone = 'phone';
  static const String password = 'password';
  static const String confirmPassword = 'confirm_password';
  static const String photo = 'photo';
  static const String bio = 'bio';

  static const String oldPassword = 'old_password';
  static const String newPassword = 'new_password';
  static const String otp = 'otp';

  //subjects
  static const String subjectId = 'id';
  static const String subjectTitle = 'title';
  static const String subjectSlug = 'slug';
  static const String subjectphoto = 'photo';
  static const String subjectCoursesTotal = 'total_courses';

  //courses
  static const String courseId = 'id';
  static const String courseTeacher = 'teacher';
  static const String courseTitle = 'title';
  static const String courseSubject = 'subject';
  static const String courseOverview = 'overview';
  static const String coursePhoto = 'photo';
  static const String courseTotalStudents = 'total_students';
  static const String courseTotalModules = 'total_modules';
  static const String courseCreated = 'created';
}
