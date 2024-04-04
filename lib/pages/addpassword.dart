import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getwidget/components/toast/gf_toast.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';
import 'package:randompassword/controllers/storagefunc.dart';
import 'package:randompassword/pages/landing.dart';
import '../utils/constants/colors.dart';
import '../utils/helpers/helper_functions.dart';

class AddPasswordScreen extends StatelessWidget {
  const AddPasswordScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final dark = MFHelperFunctions.isDarkMode(context);
    final iconController = TextEditingController();
    final sitenameController = TextEditingController();
    final usernameController = TextEditingController();
    final passwordController = TextEditingController();
    final passwordStorage = PasswordStorage();

    return KeyboardDismisser(
      gestures: const [GestureType.onPanUpdateAnyDirection, GestureType.onTap],
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              Get.off(() => const LandingPage());
            },
            icon: const Icon(PixelArtIcons.arrow_left),
          ),
          title: Text(
            "Add Password",
            style: Theme.of(context).textTheme.headlineSmall,
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 15),
            child: Column(
              children: [
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: dark ? const Color(0xFF191919) : const Color(0xFFF5F5F5),
                    border: Border.all(
                      color: dark ? MFColors.darkGrey : MFColors.primary,
                      width: 2,
                    ),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 5.0, bottom: 8),
                        child: Text(
                          "Site Name",
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                      ),
                      CustomTextfield(
                        controller: sitenameController,
                        hint: "dumbsite",
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 5.0, bottom: 8),
                        child: Text(
                          "Emoji",
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                      ),
                      CustomTextfield(
                        controller: iconController,
                        hint: "🤖",
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 5.0, bottom: 8),
                        child: Text(
                          "Username",
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                      ),
                      CustomTextfield(
                        controller: usernameController,
                        hint: "goofy username",
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 5.0, bottom: 8),
                        child: Text(
                          "Password",
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                      ),
                      CustomTextfield(
                        controller: passwordController,
                        hint: "lame password",
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Divider(
                        height: 25,
                        thickness: 2,
                        color: dark ? MFColors.darkGrey : MFColors.primary,
                      ),
                      SizedBox(
                        width: double.infinity,
                        child: OutlinedButton(
                          onPressed: () {
                            if (sitenameController.text.trim().isNotEmpty &&
                                iconController.text.trim().isNotEmpty &&
                                usernameController.text.trim().isNotEmpty &&
                                passwordController.text.trim().isNotEmpty) {
                              passwordStorage.savePassword(
                                sitenameController.text.trim(),
                                iconController.text.trim(),
                                usernameController.text.trim(),
                                passwordController.text.trim(),
                              );
                              sitenameController.clear();
                              iconController.clear();
                              usernameController.clear();
                              passwordController.clear();
                            } else {
                              GFToast.showToast(
                                "Please fill all fields",
                                context,
                                textStyle: Theme.of(context).textTheme.bodyMedium,
                                toastBorderRadius: 5.0,
                                backgroundColor: dark ? Colors.black : MFColors.accent,
                              );
                            }
                          },
                          style: OutlinedButton.styleFrom(
                            backgroundColor: dark ? const Color(0xFF191919) : const Color(0xFFFAFAFA),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5),
                            ),
                            side: BorderSide(
                              width: 2,
                              color: dark ? MFColors.darkGrey : MFColors.primary,
                            ),
                          ),
                          child: Text(
                            "Save Password",
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class CustomTextfield extends StatelessWidget {
  const CustomTextfield({
    super.key,
    required this.controller,
    required this.hint,
  });

  final TextEditingController controller;
  final String hint;

  @override
  Widget build(BuildContext context) {
    final dark = MFHelperFunctions.isDarkMode(context);
    return SizedBox(
      width: double.infinity,
      height: 60,
      child: TextField(
        controller: controller,
        style: Theme.of(context).textTheme.titleLarge,
        decoration: InputDecoration(
          hintText: hint,
          filled: true,
          fillColor: dark ? const Color(0xFF191919) : const Color(0xFFF5F5F5),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(0),
          ),
        ),
      ),
    );
  }
}
