import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:randompassword/pages/landing.dart';
import 'utils/theme/theme.dart';
import 'package:get_storage/get_storage.dart';

void main() async {
  await GetStorage.init();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.system,
      theme: MFAppTheme.lightTheme,
      darkTheme: MFAppTheme.darkTheme,
      home: const Scaffold(body: LandingPage()),
    );
  }
}
