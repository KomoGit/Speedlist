import 'package:blurrycontainer/blurrycontainer.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:speedlist/debug/print.dart';

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
          BlurryContainer.square(
            blur: 5,
            child: SizedBox(
              width: 400,
              height: 400,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      TextButton(
                        onPressed: () =>
                            Debug.printLog("Go to Profile Settings"),
                        child: Text(
                          "PROFILE",
                          style: GoogleFonts.bebasNeue(
                              color: Colors.grey, fontSize: 20),
                        ),
                      ),
                      const SizedBox(
                        width: 300,
                      ),
                      const Icon(
                        Icons.arrow_forward_ios,
                        color: Colors.grey,
                      ),
                      const Divider(color: Colors.grey,thickness: 10,height: 10),
                    ],
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
