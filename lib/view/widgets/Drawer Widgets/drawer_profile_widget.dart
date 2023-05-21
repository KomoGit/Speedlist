import 'package:flutter/material.dart';
import 'package:speedlist/Utilities/backend_utilities.dart';
import 'package:speedlist/Utilities/user_utilities.dart';
import 'package:speedlist/controller/user_controller.dart';

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
  late String userProfilePicture;

  @override
  void initState() {
    super.initState();
    _getUserProfilePicture();
    _user = UserUtilities.user;
  }

  _getUserProfilePicture() async {
    userProfilePicture = await UserController.getProfilePictureUrl(
        BackendUtilities.getBackendAccess(), _user);
  }

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
                  backgroundImage: NetworkImage(userProfilePicture),
                ),
              ),
              Flexible(
                child: Text("Hello ${_user.username}"),
              )
            ],
          ),
        ),
      ),
    );
  }
}
