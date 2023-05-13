import 'package:blurrycontainer/blurrycontainer.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pocketbase/pocketbase.dart';

import '../Utilities/backend_utilities.dart';
import '../Utilities/login_utilities.dart';
import '../debug/print.dart';

PocketBase pb = PocketBase("http://192.168.0.104:8090");
LoginUtilities loginUtilities = LoginUtilities();
final TextEditingController _usernameController = TextEditingController();
final TextEditingController _emailController = TextEditingController();
final List<TextEditingController> _passController = List.generate(
    2, (i) => TextEditingController(),
    growable: false); //Contains pass and confirm pass values.

class Register extends StatelessWidget {
  const Register({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage("assets/images/pexels-photo-1379636.jpeg"),
              fit: BoxFit.cover),
        ),
        child: const RegisterPageInput());
  }
}

class RegisterPageInput extends StatefulWidget {
  const RegisterPageInput({super.key});

  @override
  State<RegisterPageInput> createState() => _RegisterPageInputState();
}

class _RegisterPageInputState extends State<RegisterPageInput> {
  bool isUsernameEmpty = false;
  bool isEmailEmpty = false;
  bool isPasswordEmpty = false;
  bool isConfirmPassEmpty = false;
  bool isPasswordValid = true;
  bool isEmailValid = true;
  late bool isPasswordSame;

  @override
  void dispose() {
    super.dispose();
    _usernameController.dispose();
    _emailController.dispose();
    _passController[0].dispose();
    _passController[1].dispose();
  }

  void _checkInput() {
    setState(() {
      isEmailEmpty = _emailController.text.isEmpty;
      isPasswordEmpty = _passController[0].text.isEmpty;
      isConfirmPassEmpty = _passController[1].text.isEmpty;
      isPasswordValid =
          loginUtilities.passwordValidator(_passController[0].text);
      isEmailValid = loginUtilities.emailValidator(_emailController.text);
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
                height: 600,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Register",
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
                          borderSide: BorderSide(color: Colors.red),
                        ),
                        errorText: isEmailEmpty
                            ? "Login cannot be empty"
                            : !isEmailValid
                                ? "Email you have entered is invalid"
                                : null,
                        suffixIcon: const Icon(
                          Icons.email_outlined,
                          color: Colors.white,
                        ),
                        border: InputBorder.none,
                        contentPadding: const EdgeInsets.all(20),
                      ),
                    ),
                    TextField(
                      controller: _passController[0],
                      style: GoogleFonts.montserrat(color: Colors.white),
                      obscureText: true,
                      decoration: InputDecoration(
                        hintStyle:
                            const TextStyle(fontSize: 17, color: Colors.white),
                        hintText: "Insert your password",
                        errorBorder: const UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.red),
                        ),
                        errorText:
                            isPasswordEmpty ? "Password cannot be empty" : null,
                        suffixIcon: const Icon(Icons.lock_open_outlined,
                            color: Colors.white),
                        border: InputBorder.none,
                        contentPadding: const EdgeInsets.all(20),
                      ),
                    ),
                    TextField(
                      controller: _passController[1],
                      style: GoogleFonts.montserrat(color: Colors.white),
                      obscureText: true,
                      decoration: InputDecoration(
                        hintStyle:
                            const TextStyle(fontSize: 17, color: Colors.white),
                        hintText: "Confirm your password",
                        errorBorder: const UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.red),
                        ),
                        errorText: isConfirmPassEmpty
                            ? "Please write the password again"
                            : null,
                        suffixIcon: const Icon(Icons.lock, color: Colors.white),
                        border: InputBorder.none,
                        contentPadding: const EdgeInsets.all(20),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () async {
                        Debug.printLog("Clicked Register.");
                        // _checkInput();
                        // if (!isEmailEmpty && !isPassEmpty && isEmailValid) {
                        //   await BackendUtilities.checkBackendHealth()
                        //       .then((isConnected) {
                        //     if (!isConnected) {
                        //       loginFailAlert(context,
                        //           "Connection to server could not be established. Try again later.");
                        //     }
                        //   });
                        //   // UserModel user = await UserController.authUser(
                        //   //     pb, _emailController.text, _passController.text);
                        //   // if (!user.isVerified && mounted) {
                        //   //   await loginFailAlert(context,
                        //   //       "The user is not yet verified. Check your email.");
                        //   // }
                        // }
                      },
                      style: ButtonStyle(
                        shape: MaterialStatePropertyAll(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                        ),
                      ),
                      child: const Text("Register"),
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
