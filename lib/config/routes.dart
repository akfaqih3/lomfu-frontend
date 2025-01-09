import 'package:get/get.dart';
import 'package:lomfu_app/modules/onboarding/onboarding_page.dart';

class Pages {
  static const onboarding = '/onboarding';
  static const login = '/login';
  static const signUp = '/signUp';
}

class AppRoutes {
  static const initialRoute = Pages.onboarding;
  @override
  static List<GetPage> getPages = [
    GetPage(name: Pages.onboarding, page: () => OnboardingPage()),
    // GetPage(name: Pages.login, page: () => LoginPage()),
    // GetPage(name: Pages.signUp, page: () => SignUpPage()),
  ];
}
