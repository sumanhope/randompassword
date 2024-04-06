import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:iconsax/iconsax.dart';
import 'package:randompassword/pages/activitylog.dart';
import 'package:randompassword/pages/passwordmanager.dart';
import 'package:randompassword/utils/constants/colors.dart';
import '../utils/helpers/helper_functions.dart';
import 'home.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({super.key});

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  final List<Widget> pages = [
    const HomeScreen(),
    const PasswordManagerScreen(),
    const ActivityLogScreen(),
  ];

  int currentStep = 0;

  @override
  Widget build(BuildContext context) {
    final dark = MFHelperFunctions.isDarkMode(context);
    return WillPopScope(
      onWillPop: () async {
        final shouldPop = await showDialog(
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
              title: const Text("Exit Random Password"),
              content: const Text("Do you want to exit this application?"),
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
                        child: const Text("No"),
                      ),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () {
                          SystemNavigator.pop();
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
                        child: const Text("Yes"),
                      ),
                    ),
                  ],
                ),
              ],
            );
          },
        );
        // final shouldPop = await showDialog<bool>(
        //   context: context,
        //   builder: (context) {
        //     return AlertDialog(
        //       title: const Text('Do you want to exit the application?'),
        //       actionsAlignment: MainAxisAlignment.spaceBetween,
        //       actions: [
        //         TextButton(
        //           onPressed: () {
        //             SystemNavigator.pop();
        //           },
        //           child: const Text('Yes'),
        //         ),
        //         TextButton(
        //           onPressed: () {
        //             Navigator.pop(context, false);
        //           },
        //           child: const Text('No'),
        //         ),
        //       ],
        //     );
        //   },
        // );
        return shouldPop!;
      },
      child: Scaffold(
        body: pages[currentStep],
        bottomNavigationBar: Container(
          color: dark ? Colors.black : MFColors.primary,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 11),
            child: GNav(
              haptic: false,
              hoverColor: Colors.white10,
              backgroundColor: dark ? Colors.black : MFColors.primary,
              color: const Color.fromARGB(218, 224, 224, 224),
              activeColor: dark ? Colors.black : Colors.white,
              tabBackgroundColor: dark ? const Color(0xFF191919) : const Color.fromRGBO(66, 160, 71, 1),
              gap: 4,
              padding: const EdgeInsets.all(10),
              iconSize: 25,
              textStyle: const TextStyle(
                fontSize: 15,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
              tabs: [
                GButton(
                  icon: currentStep == 0 ? Iconsax.home5 : Iconsax.home_1,
                  iconActiveColor: Colors.white,
                  iconColor: Colors.white,
                  text: "Home",
                ),
                GButton(
                  icon: currentStep == 1 ? Iconsax.password_check5 : Iconsax.password_check,
                  text: "Password",
                  iconActiveColor: Colors.white,
                  iconColor: Colors.white,
                ),
                GButton(
                  icon: currentStep == 2 ? Iconsax.alarm5 : Iconsax.alarm,
                  text: "Activity Log",
                  iconActiveColor: Colors.white,
                  iconColor: Colors.white,
                ),
              ],
              selectedIndex: currentStep,
              onTabChange: (index) {
                setState(() {
                  currentStep = index;
                });
              },
            ),
          ),
        ),
      ),
    );
  }
}
