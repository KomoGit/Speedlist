import 'package:flutter/material.dart';
import 'package:speedlist/debug/print.dart';

import '../../model/user.dart';
import 'Drawer Widgets/drawer_profile_widget.dart';

// Problem arises when we view home in without logging in. As this causes initialization error.
// Solution would be to make a default user and override that user when logging in.
// When logging out we will do the opposite.
class PersistentDrawer extends StatelessWidget {
  final UserModel user;
  const PersistentDrawer({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const DrawerProfileWidget(), //When adding a list item, ensure that you have added them on Localization first.
          ElevatedButton.icon(
            onPressed: () => Debug.printLog("Home Button Clicked"),
            style: const ButtonStyle(
              alignment: Alignment.center,
            ),
            icon: const Icon(
              size: 32,
              Icons.home_outlined,
              color: Colors.white,
            ),
            label: const Text("Home"),
          ),
        ],
      ),
    );
  }
}
