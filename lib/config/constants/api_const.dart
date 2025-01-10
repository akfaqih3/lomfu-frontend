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
  //accounts endpoints
  static String login = "$apiKey$version${apps['accounts']}login/";
  static String logout = "$apiKey$version${apps['accounts']}logout/";
  static String register = "$apiKey$version${apps['accounts']}register/";
  static String verifyEmail = "$apiKey$version${apps['accounts']}otp-verify/";
  static String resendOTP = "$apiKey$version${apps['accounts']}otp-send/";
  static String forgotPassword ="$apiKey$version${apps['accounts']}password-reset/";
  static String resetPassword ="$apiKey$version${apps['accounts']}password-reset/confirm/";
  static String subjects = "$apiKey$version${apps['courses']}subjects/";
}
