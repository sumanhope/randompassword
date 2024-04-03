import 'package:get/get.dart';

class PasswordEyeController extends GetxController {
  RxBool hide = true.obs;

  void toggleButton() {
    hide.value = !hide.value;
  }
}
