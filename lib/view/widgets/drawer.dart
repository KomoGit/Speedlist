import 'package:flutter/material.dart';
import 'package:speedlist/Utilities/user_utilities.dart';
import 'package:speedlist/controller/user_preferences_db_controller.dart';
import 'package:speedlist/view/home.dart';
import 'package:speedlist/view/user_category_items.dart';

import '../../model/user.dart';
import '../Login/login_view.dart';
import 'Drawer Widgets/drawer_profile_widget.dart';

late InternalDBController prefDbCtrl;

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
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const Home()
                ),
              );
            },
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
          ElevatedButton.icon(
            onPressed: () {
              // Debug.printLog(prefDbCtrl.getAllUsers());
            },
            style: const ButtonStyle(
              alignment: Alignment.center,
            ),
            icon: const Icon(
              size: 32,
              Icons.bug_report_outlined,
              color: Colors.white,
            ),
            label: const Text("Debug Button"),
          ),
          Visibility(
            visible: loginUtilities.isUserLoggedIn(),
            child: ElevatedButton.icon(
              onPressed: ()  {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const UserCategoryItems()
                  ),
                );
              },
              style: const ButtonStyle(
                alignment: Alignment.center,
              ),
              icon: const Icon(
                size: 32,
                Icons.account_tree_outlined,
                color: Colors.white,
              ),
              label: const Text("My Listings"),
            ),
          ),
          ElevatedButton.icon(
            onPressed: ()  {
              UserUtilities.setUserToDefault();
              Navigator.push(
                  context,
                  MaterialPageRoute(
                  builder: (context) => const LoginPage(),),
              );
            },
            style: const ButtonStyle(
              alignment: Alignment.center,
            ),
            icon: const Icon(
              size: 32,
              Icons.login_outlined,
              color: Colors.white,
            ),
            label: Text(!loginUtilities.isUserLoggedIn() ? "Log In" : "Log Out"),
          ),
        ],
      ),
    );
  }
}
