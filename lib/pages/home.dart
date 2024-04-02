import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:getwidget/getwidget.dart';
import 'package:iconsax/iconsax.dart';
import 'package:randompassword/controllers/checkboxcontroller.dart';
import 'package:randompassword/controllers/themecontroller.dart';
import 'package:randompassword/utils/constants/colors.dart';
import 'package:randompassword/utils/helpers/helper_functions.dart';
import 'package:randompassword/utils/popus/loader.dart';

import '../password.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final themeCont = Get.put(ThemeController());
    final checkboxCont = Get.put(CheckboxController());
    final passwordController = TextEditingController();
    final lengthCont = Get.put(LengthController());
    final dark = MFHelperFunctions.isDarkMode(context);
    int passwordLength = 8;
    return Scaffold(
      appBar: AppBar(
        leading: Obx(
          () => IconButton(
            onPressed: () {
              themeCont.toggleTheme();
              Get.changeThemeMode(
                themeCont.dark.value ? ThemeMode.dark : ThemeMode.light,
              );
            },
            icon: themeCont.dark.value ? const Icon(Iconsax.moon) : const Icon(Iconsax.sun_1),
          ),
        ),
        title: const Text("Home"),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Iconsax.logout_1),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Container(
            color: dark ? Colors.black : MFColors.lightContainer,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 10, bottom: 2.0),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Create new password",
                        style: Theme.of(context).textTheme.headlineMedium,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8.0, right: 8),
                    child: Text(
                      "Select at least three options with 11 or more length to generate strong password.",
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  TextField(
                    controller: passwordController,
                    readOnly: true,
                    style: Theme.of(context).textTheme.titleLarge,
                    decoration: InputDecoration(
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
                              if (passwordController.text.isEmpty) {
                                return;
                              }
                              Clipboard.setData(
                                ClipboardData(text: passwordController.text),
                              );
                              // Show some feedback to the user
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
                  const SizedBox(
                    height: 15,
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      border: Border.all(
                        color: dark ? MFColors.darkGrey : MFColors.primary,
                        width: 2,
                      ),
                    ),
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 15,
                        ),
                        Container(
                          width: 400,
                          padding: const EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            color: dark ? Colors.black : MFColors.white,
                            borderRadius: BorderRadius.circular(5),
                            border: Border.all(
                              color: dark ? MFColors.darkGrey : MFColors.primary,
                              width: 2,
                            ),
                          ),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(left: 5),
                                    child: Text(
                                      "Length",
                                      style: Theme.of(context).textTheme.titleMedium,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(right: 5),
                                    child: Obx(
                                      () => Text(
                                        "${(lengthCont.length.value * 100).ceil()}",
                                        style: Theme.of(context).textTheme.titleMedium,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Obx(
                                () => SizedBox(
                                  width: 360,
                                  child: Slider(
                                    max: 0.3,
                                    min: 0.07,
                                    activeColor: dark ? MFColors.buttonDisabled : MFColors.primary,
                                    value: lengthCont.length.value,
                                    inactiveColor: dark ? MFColors.darkerGrey : MFColors.borderSecondary,
                                    onChanged: (value) {
                                      lengthCont.changeLength(value);
                                      passwordLength = (lengthCont.length.value * 100).ceil();
                                    },
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Obx(
                          () => ListView(
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            children: checkboxCont.checkboxMap.keys.map(
                              (key) {
                                return OptionContainer(
                                  dark: dark,
                                  func: () {
                                    checkboxCont.toggleCheckboxState(key);
                                  },
                                  title: key,
                                  isChecked: checkboxCont.checkboxMap[key]!.value,
                                );
                              },
                            ).toList(),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    width: 400,
                    child: OutlinedButton(
                      onPressed: () {
                        String password = generateRandomPassword(
                          length: passwordLength,
                          includeUpperCase: checkboxCont.checkboxMap["Uppercase (A-Z)"]!.value,
                          includeLowerCase: checkboxCont.checkboxMap["Lowercase (a-z)"]!.value,
                          includeNumbers: checkboxCont.checkboxMap["Digits (0-9)"]!.value,
                          includeSymbols: checkboxCont.checkboxMap["Symbols (!@#\$%^&*()_-)"]!.value,
                        );

                        passwordController.value = TextEditingValue(text: password);
                      },
                      style: OutlinedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                        side: BorderSide(
                          width: 2,
                          color: dark ? MFColors.darkGrey : MFColors.primary,
                        ),
                      ),
                      child: Text(
                        "Generate Password",
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class OptionContainer extends StatelessWidget {
  const OptionContainer({
    super.key,
    required this.dark,
    required this.func,
    required this.title,
    required this.isChecked,
  });

  final bool dark;
  final VoidCallback func;
  final String title;
  final bool isChecked;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15.0),
      child: Container(
        width: 400,
        padding: const EdgeInsets.all(5),
        decoration: BoxDecoration(
          color: dark ? Colors.black : MFColors.white,
          borderRadius: BorderRadius.circular(5),
          border: Border.all(
            color: dark ? MFColors.darkGrey : MFColors.primary,
            width: 2,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 5),
              child: Text(
                title,
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ),
            GFCheckbox(
              type: GFCheckboxType.custom,
              customBgColor: dark ? Colors.black : MFColors.primary,
              size: GFSize.SMALL,
              onChanged: (value) {
                func();
              },
              value: isChecked,
            ),
          ],
        ),
      ),
    );
  }
}
