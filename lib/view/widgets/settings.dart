import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:speedlist/debug/print.dart';

import '../../Utilities/user_utilities.dart';
import '../../model/user.dart';

final UserModel _user = UserUtilities.user;
class Settings extends StatelessWidget {
  const Settings({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      appBar: AppBar(title: const Text("Settings")),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
            SizedBox(
              width: 400,
              height: 400,
              child: Column(
                //mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const Divider(thickness: 1),
                  Row(
                    children: [
                      TextButton(
                        onPressed: () =>
                            Debug.printLog("Go to Profile Settings"),
                        child: Text(
                          "PROFILE",
                          style: GoogleFonts.bebasNeue(
                              color: Colors.grey[800], fontSize: 20),
                        ),
                      ),
                      const SizedBox(
                        width: 300,
                      ),
                      const Icon(
                        Icons.arrow_forward_ios,
                        color: Colors.grey,
                      ),
                    ],
                  ),
                  const Divider(thickness: 1),
                ],
              ),
            ),
          SizedBox(
            width: 100,
            height: 100,
            child: Row(
              children: [
                CircleAvatar(
                  maxRadius: 40,
                  backgroundImage: NetworkImage(_user.profilePicture),

                ),
              ],
            )
          )
        ],
      ),
    );
  }
}
