import 'package:blurrycontainer/blurrycontainer.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pocketbase/pocketbase.dart';
import 'package:speedlist/controller/user_controller.dart';
import 'package:speedlist/debug/debug_out.dart';
import 'package:speedlist/view/widgets/oauth_login_buttons.dart';

import 'home.dart';

PocketBase pb = PocketBase("http://192.168.0.104:8090");
final TextEditingController _emailController = TextEditingController();
final TextEditingController _passController = TextEditingController();

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage("assets/images/pexels-photo-1379636.jpeg"),
              fit: BoxFit.cover),
        ),
        child: const LoginPageInput());
  }
}

class LoginPageInput extends StatefulWidget {
  const LoginPageInput({super.key});

  @override
  State<LoginPageInput> createState() => _LoginPageInputState();
}

class _LoginPageInputState extends State<LoginPageInput> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.transparent,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: BlurryContainer.square(
              blur: 5,
              child: SizedBox(
                width: 350,
                height: 350,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      "Login",
                      style: GoogleFonts.bebasNeue(
                          color: Colors.white, fontSize: 24, letterSpacing: 2),
                    ),
                    TextField(
                      controller: _emailController,
                      style: GoogleFonts.montserrat(color: Colors.white),
                      decoration: const InputDecoration(
                        hintStyle: TextStyle(fontSize: 17, color: Colors.white),
                        hintText: "Insert your email",
                        suffixIcon: Icon(
                          Icons.email_outlined,
                          color: Colors.white,
                        ),
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.all(20),
                      ),
                    ),
                    TextField(
                      controller: _passController,
                      style: GoogleFonts.montserrat(color: Colors.white),
                      obscureText: true,
                      decoration: const InputDecoration(
                        hintStyle: TextStyle(fontSize: 17, color: Colors.white),
                        hintText: "Insert your password",
                        suffixIcon:
                            Icon(Icons.lock_open_outlined, color: Colors.white),
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.all(20),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () async {
                        // bool isLoginSuccesful =
                        //     await UserController.attemptLogin(pb,
                        //         _emailController.text, _passController.text);
                        // if (!isLoginSuccesful) {
                        //   const LoginDialogue(
                        //     message:
                        //         'Login failed, check your email or password',
                        //   );
                        // }
                        // DebugOut.printLog(isLoginSuccesful.toString());
                      },
                      style: ButtonStyle(
                        shape: MaterialStatePropertyAll(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                        ),
                      ),
                      child: const Text("Login"),
                    ),
                    TextButton(
                      onPressed: () {
                        DebugOut.printLog("Clicked register");
                        // Navigator.push(
                        //     context,
                        //     MaterialPageRoute(
                        //         builder: ((context) => const RegisterPage())));
                      },
                      child: const Text.rich(
                        TextSpan(
                          text: "Not a member? ",
                          style: TextStyle(fontSize: 12, color: Colors.white),
                          children: <TextSpan>[
                            TextSpan(
                                text: "Register.",
                                style: TextStyle(
                                  color: Colors.blue,
                                  decoration: TextDecoration.underline,
                                )),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: 10),
          Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: const [
                OAuthButton(iconAsset: "assets/icons/facebook.png"),
                SizedBox(
                  width: 10,
                ),
                OAuthButton(iconAsset: "assets/icons/search.png"),
                SizedBox(
                  width: 10,
                ),
                OAuthButton(iconAsset: "assets/icons/microsoft.png")
              ],
            ),
          ),
          TextButton(
            child: const Text(
              "Forgot my password.",
              style: TextStyle(
                fontSize: 12,
                color: Colors.white,
                decoration: TextDecoration.underline,
              ),
            ), //TODO: TEMPORARY MEASURE. REMOVE THIS IN PROD.
            onPressed: () => {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const Home()))
            },
          )
        ],
      ),
    );
  }
}

class LoginDialogue extends StatelessWidget {
  final String message;
  const LoginDialogue({required this.message, super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(message),
      actions: <Widget>[
        TextButton(
          child: const Text("OK"),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}
