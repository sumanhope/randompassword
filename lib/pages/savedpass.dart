import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:icons_plus/icons_plus.dart';
import '../widgets/savepasswordcontainer.dart';

class SavedPassScreen extends StatelessWidget {
  const SavedPassScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
              title: "Discord",
              usernameController: TextEditingController(text: "pauorti"),
              passwordController: TextEditingController(text: "Acupoftea1"),
            ),
          ],
        ),
      ),
    );
  }
}
