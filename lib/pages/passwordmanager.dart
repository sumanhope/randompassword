import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getwidget/getwidget.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:randompassword/pages/addpassword.dart';
import 'package:randompassword/pages/savedpass.dart';
import 'package:randompassword/utils/constants/colors.dart';
import 'package:randompassword/utils/helpers/helper_functions.dart';

class PasswordManagerScreen extends StatelessWidget {
  const PasswordManagerScreen({super.key});
  @override
  Widget build(BuildContext context) {
    List<Map<String, String>> passwordDataList = [
      {"title": "Discord", "username": "pauroti"},
      {"title": "Facebook", "username": "Suman"},
      {"title": "Reddit", "username": "pauroti"},
      {"title": "Gmail", "username": "sumansthahope@gmail.com"},
      {"title": "Instagram", "username": "paurotiii"},
      {"title": "Full Novel", "username": "pauroti"},
    ];
    final dark = MFHelperFunctions.isDarkMode(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Password Manager",
          style: Theme.of(context).textTheme.headlineSmall,
        ),
        actions: [
          IconButton(
            onPressed: () {
              GFToast.showToast(
                "I'm gonna sell you data now, HUHAHAHAHA",
                context,
                textStyle: Theme.of(context).textTheme.bodyMedium,
                toastBorderRadius: 5.0,
                backgroundColor: dark ? Colors.black : MFColors.accent,
              );
            },
            icon: const Icon(Iconsax.ghost),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.to(() => const AddPasswordScreen());
        },
        tooltip: "Add Password",
        backgroundColor: dark ? Colors.black : MFColors.primary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        child: const Icon(
          OctIcons.plus_16,
          size: 30,
          color: Colors.white,
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 10.0, top: 10, bottom: 8),
              child: Text(
                "Passwords",
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ),
            ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: passwordDataList.length,
              itemBuilder: (context, index) {
                final data = passwordDataList[index];
                return PasswordTile(title: data["title"]!, subtitle: data["username"]!);
              },
            ),
          ],
        ),
      ),
    );
  }
}

class PasswordTile extends StatelessWidget {
  const PasswordTile({
    super.key,
    required this.title,
    required this.subtitle,
  });

  final String title, subtitle;

  @override
  Widget build(BuildContext context) {
    final dark = MFHelperFunctions.isDarkMode(context);
    return Container(
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            width: 2,
            color: dark ? MFColors.darkGrey : MFColors.primary,
          ),
        ),
      ),
      child: ListTile(
        tileColor: dark ? const Color(0xFF191919) : Colors.white,
        title: Text(
          title,
          style: Theme.of(context).textTheme.titleLarge,
        ),
        subtitle: Text(
          subtitle,
          style: Theme.of(context).textTheme.bodyLarge,
        ),
        onTap: () {
          Get.to(() => const SavedPassScreen());
        },
      ),
    );
  }
}
