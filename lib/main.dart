import 'package:flutter/material.dart';
import 'package:lomfu_app/home.dart';
import 'package:get_storage/get_storage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  runApp(const AppHome());
}
