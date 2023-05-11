import 'package:flutter/material.dart';
import 'package:speedlist/view/home.dart';

class PersistentDrawer extends StatelessWidget {
  const PersistentDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.5),
                  spreadRadius: 5,
                  blurRadius: 7,
                  offset: const Offset(-10, 1),
                )
              ],
              image: const DecorationImage(
                  image: AssetImage(
                      "assets/images/pexels-photo-13766882.jpeg"), //Make it so this image can be changed in settings.
                  fit: BoxFit.cover),
            ),
            child: InkWell(
              // onTap: (() => DebugOut.printLog("Profile Clicked")),
              onTap: (() => Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const Home()))),
              child: const Padding(
                padding: EdgeInsets.all(0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Flexible(
                        child: CircleAvatar(
                      maxRadius: 50,
                      backgroundImage: NetworkImage(
                          "https://randomuser.me/api/portraits/women/31.jpg"),
                    )),
                    Flexible(
                      child: Text("Hello User"),
                    )
                  ],
                ),
              ),
            ),
          ), //When adding a list item, ensure that you have added them on Localization first.
        ],
      ),
    );
  }
}
