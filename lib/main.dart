import 'package:flutter/material.dart';
import 'package:lomfu_app/home.dart';
import 'package:get_storage/get_storage.dart';
// import 'helpers/linkHandlerService.dart';

// LinkHandlerService _linkHandlerService = LinkHandlerService();
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  // _linkHandlerService.initDeepLinks();
  runApp(const AppHome());
}
