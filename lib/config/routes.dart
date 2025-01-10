import 'package:get/get.dart';
import 'package:lomfu_app/modules/onboarding/onboarding_page.dart';
import 'package:lomfu_app/modules/auth/views/login_page.dart';
import 'package:lomfu_app/modules/auth/views/signup_page.dart';
import 'package:lomfu_app/modules/auth/views/home_page.dart';
import 'package:lomfu_app/modules/auth/views/confirm_email_page.dart';
import 'package:lomfu_app/modules/auth/views/forgot_password_page.dart';
import 'package:lomfu_app/modules/auth/views/password_reset_page.dart';

class Pages {
  static const home = '/home';
  static const onboarding = '/onboarding';
  static const login = '/login';
  static const signUp = '/signUp';
  static const confirmEmail = '/confirmEmail';
  static const forgotPassword = '/forgotPassword';
  static const passwordReset = '/passwordReset';
}

class AppRoutes {
  static const initialRoute = Pages.onboarding;
  @override
  static List<GetPage> getPages = [
    GetPage(name: Pages.onboarding, page: () => OnboardingPage()),
    GetPage(name: Pages.login, page: () => LoginPage()),
    GetPage(name: Pages.signUp, page: () => SignUpPage()),
    GetPage(name: Pages.confirmEmail, page: () => ConfirmEmailPage()),
    GetPage(name: Pages.forgotPassword, page: () => ForgotPasswordPage()),
    GetPage(name: Pages.passwordReset, page: () => PasswordResetPage()),
    GetPage(name: Pages.home, page: () => HomePage()),
  ];
}
