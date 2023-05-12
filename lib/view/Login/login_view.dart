import 'package:blurrycontainer/blurrycontainer.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pocketbase/pocketbase.dart';
import 'package:speedlist/Backend/backend_utilities.dart';
import 'package:speedlist/controller/user_controller.dart';
import 'package:speedlist/debug/print.dart';
import 'package:speedlist/model/user.dart';
import 'package:speedlist/view/Login/login_forgot_password.dart';
import 'package:speedlist/view/widgets/Login%20Widgets/oauth_login_buttons.dart';

//import '../home.dart';

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
  bool isLoginEmpty = false;
  bool isPassEmpty = false;

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passController.dispose();
  }

  //perhaps this should be a bool? We could also split it into two differrent methods to keep up with S.O.L.I.D principles.
  void _checkInput() {
    setState(() {
      isLoginEmpty = _emailController.text.isEmpty;
      isPassEmpty = _passController.text.isEmpty;
      return;
    });
  }

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
                      decoration: InputDecoration(
                        hintStyle:
                            const TextStyle(fontSize: 17, color: Colors.white),
                        hintText: "Insert your email",
                        errorBorder: const UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.red)),
                        errorText:
                            isLoginEmpty ? "Login cannot be empty" : null,
                        suffixIcon: const Icon(
                          Icons.email_outlined,
                          color: Colors.white,
                        ),
                        border: InputBorder.none,
                        contentPadding: const EdgeInsets.all(20),
                      ),
                    ),
                    TextField(
                      controller: _passController,
                      style: GoogleFonts.montserrat(color: Colors.white),
                      obscureText: true,
                      decoration: InputDecoration(
                        hintStyle:
                            const TextStyle(fontSize: 17, color: Colors.white),
                        hintText: "Insert your password",
                        errorBorder: const UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.red)),
                        errorText:
                            isPassEmpty ? "Password cannot be empty" : null,
                        suffixIcon: const Icon(Icons.lock_open_outlined,
                            color: Colors.white),
                        border: InputBorder.none,
                        contentPadding: const EdgeInsets.all(20),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () async {
                        _checkInput();
                        if (!isLoginEmpty && !isPassEmpty) {
                          await BackendUtilities.checkBackendHealth()
                              .then((isConnected) {
                            if (!isConnected) {
                              loginFailAlert(context,
                                  "Connection to server could not be established. Try again later.");
                            }
                          });
                          UserModel user = await UserController.authUser(
                              pb, _emailController.text, _passController.text);
                          if (!user.isVerified && mounted) {
                            await loginFailAlert(context,
                                "The user is not yet verified. Check your email.");
                          }
                        }
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
                        Debug.printLog("Clicked register");
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
          const Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
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
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const ForgotPassword()))
            },
          )
        ],
      ),
    );
  }

  Future<dynamic> loginFailAlert(BuildContext context, String msg) =>
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return BlurryContainer.square(
              child: AlertDialog(
                backgroundColor: Colors.white,
                title: const Center(child: Text("Attention")),
                content: Text(msg),
                actions: [
                  TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: const Text("Ok."))
                ],
              ),
            );
          });
}
