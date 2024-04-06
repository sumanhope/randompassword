import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:getwidget/getwidget.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:randompassword/utils/constants/colors.dart';
import 'package:randompassword/utils/helpers/helper_functions.dart';

class ActivityLogScreen extends StatelessWidget {
  const ActivityLogScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final logs = [
      {
        "Sat, April 06 2024": [
          "Filling Logs",
          "Minor UI Changes",
          "Show Dialog",
        ]
      },
      {
        "Fri, April 05 2024": [
          "Fixing storing error,",
          "Activity Logs UI.",
        ]
      },
      {
        "Thu, April 04 2024": [
          "Saved Password Backend,",
          "Edit Password Backend,",
          "Add Password Backend,",
          "Local Storage,",
          "UUID package.",
        ]
      },
      {
        "Wed, April 03 2024": [
          "Screen name Change,",
          "All Controller,",
          "Add and Saved Password UI,",
          "Minor UI changes.",
        ]
      },
      {
        "Tue, April 02 2024": [
          "Controller and Pages,",
          "Minor UI change,",
          "Layout.",
        ]
      },
      {
        "Mon, April 01 2024": [
          "Supports dark mode,",
          "App theme and utils,",
          "Fixing Multidex Error,",
          "Initializing App.",
        ]
      },
    ];
    final dark = MFHelperFunctions.isDarkMode(context);
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          "Logs",
          style: Theme.of(context).textTheme.headlineSmall,
        ),
        actions: [
          IconButton(
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
                    title: const Text("Delete All Password"),
                    content: const Text("Do you want to delete All password?"),
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
                                final storage = GetStorage();
                                storage.remove("passwords");
                                Get.back();
                                GFToast.showToast(
                                  "All saved password has been removed",
                                  context,
                                  textStyle: Theme.of(context).textTheme.bodyMedium,
                                  toastBorderRadius: 5.0,
                                  backgroundColor: dark ? Colors.black : MFColors.accent,
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
                              child: const Text("Delete All"),
                            ),
                          ),
                        ],
                      ),
                    ],
                  );
                },
              );
            },
            icon: const Icon(PixelArtIcons.close),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Next Update",
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Text(
                    "• ",
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  const Text(
                    "Currently I don't have new feature in mind yet.",
                  ),
                ],
              ),
              const Text("All of the features that i want has been done."),
              const SizedBox(
                height: 20,
              ),
              Text(
                "Updated Logs",
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              const SizedBox(
                height: 20,
              ),
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: logs.length,
                itemBuilder: (context, index) {
                  var log = logs[index];
                  var logNumber = log.keys.first;
                  var logEntries = log.values.first;
                  return Column(
                    children: [
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 5.0),
                            child: Container(
                              height: 20,
                              width: 2,
                              color: MFColors.darkGrey,
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 7.0),
                            child: Text(
                              logNumber,
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: logEntries.length,
                        itemBuilder: (context, index) {
                          var entry = logEntries[index];
                          return Row(
                            children: [
                              Text(
                                "• ",
                                style: Theme.of(context).textTheme.headlineMedium,
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              Text(
                                entry,
                              ),
                            ],
                          );
                        },
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                    ],
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}

class LogsContainer extends StatelessWidget {
  const LogsContainer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 5.0),
              child: Container(
                height: 20,
                width: 2,
                color: MFColors.darkGrey,
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 7.0),
              child: Text(
                "Key",
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 5,
        ),
        Row(
          children: [
            Text(
              "• ",
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(
              width: 5,
            ),
            const Text(
              "Values",
            ),
          ],
        ),
      ],
    );
  }
}

// child: OutlinedButton(
//   onPressed: () {
//     final storage = GetStorage(); // Get an instance of Get Storage
//     storage.remove("passwords"); // Remove the passwords data from local storage

//     // Show a snackbar to indicate that all data has been cleared
//     ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
//       content: Text('All data cleared successfully'),
//     ));
//   },
//   child: const Text("Clear all"),
// ),
