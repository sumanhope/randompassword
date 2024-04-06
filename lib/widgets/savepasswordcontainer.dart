import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:randompassword/controllers/storagefunc.dart';
import 'package:randompassword/pages/editpassword.dart';
import '../controllers/controller.dart';
import '../utils/constants/colors.dart';
import '../utils/helpers/helper_functions.dart';
import '../utils/popus/loader.dart';

class SavedPassContainer extends StatelessWidget {
  const SavedPassContainer({
    super.key,
    required this.title,
    required this.emoji,
    required this.id,
    required this.usernameController,
    required this.passwordController,
  });
  final String title, emoji, id;
  final TextEditingController usernameController;
  final TextEditingController passwordController;
  @override
  Widget build(BuildContext context) {
    final dark = MFHelperFunctions.isDarkMode(context);
    final eyeCont = Get.put(PasswordEyeController());
    final passwordStorage = PasswordStorage();

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 15),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: dark ? const Color(0xFF191919) : Colors.white,
          border: Border.all(
            color: dark ? MFColors.darkGrey : MFColors.primary,
            width: 2,
          ),
          borderRadius: BorderRadius.circular(5),
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                CircleAvatar(
                  radius: 22,
                  backgroundColor: dark ? const Color.fromARGB(255, 40, 40, 40) : const Color.fromARGB(177, 131, 201, 134),
                  //child: const Icon(EvaIcons.email_outline),
                  child: Text(emoji),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Text(
                    title,
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                ),
              ],
            ),
            Divider(
              thickness: 2,
              height: 25,
              color: dark ? MFColors.darkGrey : MFColors.primary,
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 5.0, bottom: 8),
                      child: Text(
                        "Username",
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: double.infinity,
                    height: 60,
                    child: TextField(
                      controller: usernameController,
                      readOnly: true,
                      style: Theme.of(context).textTheme.titleLarge,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: dark ? const Color(0xFF191919) : Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(0),
                        ),
                        suffixIcon: Padding(
                          padding: const EdgeInsets.only(top: 5, bottom: 5, right: 5),
                          child: Container(
                            decoration: BoxDecoration(
                              border: Border(
                                left: BorderSide(
                                  width: 2,
                                  color: dark ? MFColors.darkGrey : MFColors.primary,
                                ),
                              ),
                            ),
                            child: IconButton(
                              onPressed: () {
                                Clipboard.setData(
                                  ClipboardData(text: usernameController.text),
                                );
                                MFLoader.currentToast(message: "Copied to Clipboard");
                              },
                              icon: Icon(
                                Iconsax.copy,
                                color: dark ? MFColors.darkGrey : MFColors.primary,
                                size: 25,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 5.0, bottom: 8),
                      child: Text(
                        "Password",
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: double.infinity,
                    height: 60,
                    child: Obx(
                      () => TextField(
                        controller: passwordController,
                        readOnly: true,
                        style: Theme.of(context).textTheme.titleLarge,
                        obscureText: eyeCont.hide.value,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: dark ? const Color(0xFF191919) : Colors.white,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(0),
                          ),
                          suffixIcon: Container(
                            width: 100,
                            decoration: BoxDecoration(
                              border: Border(
                                left: BorderSide(
                                  width: 2,
                                  color: dark ? MFColors.darkGrey : MFColors.primary,
                                ),
                              ),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                IconButton(
                                  onPressed: () {
                                    eyeCont.toggleButton();
                                  },
                                  icon: Icon(
                                    eyeCont.hide.value ? PixelArtIcons.eye_closed : PixelArtIcons.eye,
                                    color: dark ? MFColors.darkGrey : MFColors.primary,
                                  ),
                                ),
                                IconButton(
                                  onPressed: () {
                                    Clipboard.setData(
                                      ClipboardData(text: passwordController.text),
                                    );

                                    MFLoader.currentToast(message: "Copied to Clipboard");
                                  },
                                  icon: Icon(
                                    Iconsax.copy,
                                    color: dark ? MFColors.darkGrey : MFColors.primary,
                                    size: 25,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Divider(
              thickness: 2,
              height: 25,
              color: dark ? MFColors.darkGrey : MFColors.primary,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () {
                      Get.to(() => EditPasswordScreen(
                            id: id,
                            sitename: title,
                            emoji: emoji,
                            username: usernameController.text,
                            password: passwordController.text,
                          ));
                    },
                    style: OutlinedButton.styleFrom(
                      backgroundColor: dark ? const Color(0xFF191919) : Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                      side: BorderSide(
                        width: 2,
                        color: dark ? MFColors.darkGrey : MFColors.primary,
                      ),
                    ),
                    child: Text(
                      "Edit",
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: OutlinedButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (_) {
                          return AlertDialog(
                            backgroundColor: dark ? const Color(0xFF191919) : Colors.white,
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5),
                              side: BorderSide(
                                width: 2,
                                color: dark ? MFColors.darkGrey : MFColors.primary,
                              ),
                            ),
                            title: const Text("Delete Password"),
                            content: const Text("Do you want to delete this password?"),
                            actions: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: OutlinedButton(
                                      onPressed: () {
                                        Get.back();
                                      },
                                      style: OutlinedButton.styleFrom(
                                        backgroundColor: dark ? const Color(0xFF191919) : Colors.white,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(5),
                                        ),
                                        side: BorderSide(
                                          width: 2,
                                          color: dark ? MFColors.darkGrey : MFColors.primary,
                                        ),
                                      ),
                                      child: const Text("Cancel"),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 20,
                                  ),
                                  Expanded(
                                    child: OutlinedButton(
                                      onPressed: () {
                                        passwordStorage.deletePassword(id);
                                      },
                                      style: OutlinedButton.styleFrom(
                                        backgroundColor: dark ? const Color(0xFF191919) : Colors.white,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(5),
                                        ),
                                        side: BorderSide(
                                          width: 2,
                                          color: dark ? MFColors.darkGrey : MFColors.primary,
                                        ),
                                      ),
                                      child: const Text("Delete"),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          );
                        },
                      );
                    },
                    style: OutlinedButton.styleFrom(
                      backgroundColor: dark ? const Color(0xFF191919) : Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                      side: BorderSide(
                        width: 2,
                        color: dark ? MFColors.darkGrey : MFColors.primary,
                      ),
                    ),
                    child: Text(
                      "Delete",
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
