import 'package:get/get.dart';

class ThemeController extends GetxController {
  RxBool dark = true.obs;

  void toggleTheme() {
    dark.value = !dark.value;
  }
}
