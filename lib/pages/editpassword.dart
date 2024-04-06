import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';
import 'package:randompassword/controllers/storagefunc.dart';
import 'package:randompassword/pages/addpassword.dart';
import 'package:randompassword/utils/constants/colors.dart';
import '../utils/helpers/helper_functions.dart';

class EditPasswordScreen extends StatelessWidget {
  const EditPasswordScreen({
    super.key,
    required this.id,
    required this.sitename,
    required this.emoji,
    required this.username,
    required this.password,
  });
  final String id, sitename, emoji, username, password;

  @override
  Widget build(BuildContext context) {
    final sitenameController = TextEditingController(text: sitename);
    final iconController = TextEditingController(text: emoji);
    final usernameController = TextEditingController(text: username);
    final passwordController = TextEditingController(text: password);
    final passwordStorage = PasswordStorage();
    final dark = MFHelperFunctions.isDarkMode(context);
    return KeyboardDismisser(
      gestures: const [GestureType.onTap, GestureType.onPanUpdateAnyDirection],
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            "Edit Password",
            style: Theme.of(context).textTheme.headlineSmall,
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
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
                        hint: "Discord",
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
                        hint: "lame username",
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
                              passwordStorage.editPassword(
                                id,
                                sitenameController.text.trim(),
                                iconController.text.trim(),
                                usernameController.text.trim(),
                                passwordController.text.trim(),
                              );
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
                            "Update Password",
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
