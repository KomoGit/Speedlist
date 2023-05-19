import 'package:flutter/material.dart';

import '../../../model/user.dart';
import '../../Login/login_view.dart';

class DrawerProfileWidget extends StatelessWidget {
  const DrawerProfileWidget({
    super.key,
    required this.user,
  });

  final UserModel user;

  @override
  Widget build(BuildContext context) {
    return DrawerHeader(
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
        //This should direct us to profile settings
        onTap: (() => Navigator.push(context,
            MaterialPageRoute(builder: (context) => const LoginPage()))),
        child: Padding(
          padding: const EdgeInsets.all(0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const Flexible(
                child: CircleAvatar(
                  maxRadius: 50,
                  backgroundImage: NetworkImage(
                      "https://randomuser.me/api/portraits/women/31.jpg"),
                ),
              ),
              Flexible(
                child: Text("Hello $user.username"),
              )
            ],
          ),
        ),
      ),
    );
  }
}
