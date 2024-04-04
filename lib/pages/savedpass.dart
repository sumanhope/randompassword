import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:icons_plus/icons_plus.dart';
import '../controllers/storagefunc.dart';
import '../widgets/savepasswordcontainer.dart';

class SavedPassScreen extends StatelessWidget {
  const SavedPassScreen({super.key, required this.id});
  final String id;
  @override
  Widget build(BuildContext context) {
    final passwordData = PasswordStorage().getPasswordById(id);

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: const Icon(PixelArtIcons.arrow_left)),
        title: Text(
          "Saved Password",
          style: Theme.of(context).textTheme.headlineSmall,
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Iconsax.ghost),
          ),
        ],
      ),
      body: Center(
        child: Column(
          children: [
            SavedPassContainer(
              title: passwordData!["sitename"]!,
              emoji: passwordData["emoji"]!,
              id: passwordData["id"]!,
              usernameController: TextEditingController(text: passwordData["username"]),
              passwordController: TextEditingController(text: passwordData["password"]),
            ),
          ],
        ),
      ),
    );
  }
}
