import 'package:get/get.dart';
import 'package:lomfu_app/helpers/localazition/app_langs/en.dart';
import 'package:lomfu_app/helpers/localazition/app_langs/ar.dart';

class Translate implements Translations {
  @override
  Map<String, Map<String, String>> get keys => {
        'en': en,
        'ar': ar,
      };
}
