import 'package:get/get.dart';

class CheckboxController extends GetxController {
  Map<String, RxBool> checkboxMap = {
    'Uppercase (A-Z)': true.obs,
    'Lowercase (a-z)': true.obs,
    'Digits (0-9)': true.obs,
    'Symbols (!@#\$%^&*()_-)': true.obs,
  };

  void toggleCheckboxState(String key) {
    checkboxMap[key]!.value = !checkboxMap[key]!.value;
  }
}

class LengthController extends GetxController {
  RxDouble length = 0.08.obs;

  void changeLength(double value) {
    length.value = value;
  }
}
