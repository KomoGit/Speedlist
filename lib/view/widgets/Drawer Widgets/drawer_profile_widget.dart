import 'package:flutter/material.dart';
import 'package:speedlist/Utilities/user_utilities.dart';

import '../../../model/user.dart';
import '../../Login/login_view.dart';

class DrawerProfileWidget extends StatefulWidget {
  const DrawerProfileWidget({
    super.key,
  });

  @override
  State<DrawerProfileWidget> createState() => _DrawerProfileWidgetState();
}

class _DrawerProfileWidgetState extends State<DrawerProfileWidget> {
  late UserModel _user;

  @override
  void initState() {
    super.initState();
    _user = UserUtilities.user;
  }

  @override
  Widget build(BuildContext context) {
    return DrawerHeader(
      decoration: const BoxDecoration(
        image: DecorationImage(
            image: AssetImage(
                "assets/images/pexels-photo-13766882.jpeg"), //Make it so this image can be changed in settings.
            fit: BoxFit.cover),
      ),
      child: InkWell(
        //This should direct us to profile settings
        onTap: (() => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const LoginPage(),
              ),
            )),
        child: Padding(
          padding: const EdgeInsets.all(0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Flexible(
                child: CircleAvatar(
                  maxRadius: 50,
                  backgroundImage: NetworkImage(_user.profilePicture),
                ),
              ),
              Flexible(
                child: Text("Hello ${_user.username}"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
