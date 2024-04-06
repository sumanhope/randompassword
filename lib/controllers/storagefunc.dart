import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:randompassword/pages/landing.dart';
import 'package:uuid/uuid.dart';

class PasswordStorage {
  void savePassword(dynamic sitename, dynamic emoji, dynamic username, dynamic password) {
    final storage = GetStorage();
    List<Map<String, dynamic>> emptyList = [];
    List<dynamic> data = storage.read('passwords') ?? emptyList;
    List<Map<String, dynamic>> passwords = data.map((item) => item as Map<String, dynamic>).toList();
    // Generate a unique ID
    var uuid = const Uuid();
    String id = uuid.v1();

    // Create a new map representing the password data
    Map<String, dynamic> newPassword = {
      'id': id,
      'sitename': sitename,
      'emoji': emoji,
      'username': username,
      'password': password,
    };

    // Add the new password data to the list
    passwords.add(newPassword);

    // Save the updated list back to local storage
    storage.write('passwords', passwords);
    Get.snackbar('Success', 'Password saved successfully');
  }

  List<Map<String, dynamic>> readDataFromLocalStorage() {
    final box = GetStorage();
    List<Map<String, dynamic>> emptyList = [];
    List<dynamic> data = box.read('passwords') ?? emptyList;
    List<Map<String, dynamic>> passwordList = data.map((item) => item as Map<String, dynamic>).toList();
    return passwordList;
  }

  void deletePassword(dynamic id) {
    final storage = GetStorage();

    // Read data from local storage and cast it to the correct type
    List<Map<String, dynamic>> passwords = (storage.read('passwords') as List?)?.cast<Map<String, dynamic>>() ?? [];

    // Convert id to string for comparison
    String idString = id.toString();

    // Remove the password entry with the specified ID from the list
    passwords.removeWhere((element) => element['id'] == idString);

    // Save the updated list back to local storage
    storage.write('passwords', passwords);

    Get.offAll(
      () => const LandingPage(),
    );

    // Show a snackbar to indicate that the password was deleted
    Get.snackbar('Success', 'Password deleted successfully');
  }

  Map<String, dynamic>? getPasswordById(String id) {
    final List<Map<String, dynamic>> data = readDataFromLocalStorage();
    final password = data.firstWhere((entry) => entry['id'] == id);
    return password;
  }

  void editPassword(String id, String sitename, String emoji, String username, String password) {
    final storage = GetStorage();
    List<Map<String, dynamic>> emptyList = [];
    List<Map<String, dynamic>> passwords = (storage.read('passwords') as List?)?.cast<Map<String, dynamic>>() ?? emptyList;

    // Find the password entry with the specified ID
    int index = passwords.indexWhere((element) => element['id'] == id);
    if (index != -1) {
      // Update the password entry
      passwords[index] = {
        'id': id,
        'sitename': sitename,
        'emoji': emoji,
        'username': username,
        'password': password,
      };

      // Save the updated list back to local storage
      storage.write('passwords', passwords);

      Get.offAll(
        () => const LandingPage(),
      );
      // Show a snackbar to indicate that the password was edited
      Get.snackbar('Success', 'Password edited successfully');
    } else {
      // Password entry with the specified ID not found
      Get.snackbar('Error', 'Password not found');
    }
  }
}
