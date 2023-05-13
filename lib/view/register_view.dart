import 'package:blurrycontainer/blurrycontainer.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pocketbase/pocketbase.dart';
import 'package:speedlist/controller/user_controller.dart';
import 'package:speedlist/model/user.dart';

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
  bool isPasswordSame = true;

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
      isUsernameEmpty = _usernameController.text.isEmpty;
      isEmailEmpty = _emailController.text.isEmpty;
      isPasswordEmpty = _passController[0].text.isEmpty;
      isConfirmPassEmpty = _passController[1].text.isEmpty;
      isPasswordValid =
          loginUtilities.passwordValidator(_passController[0].text);
      isPasswordSame = loginUtilities.arePasswordsSame(
          _passController[0].text, _passController[1].text);
      isEmailValid = loginUtilities.emailValidator(_emailController.text);
      return;
    });
  }

  bool validateInputs() {
    if (!isUsernameEmpty &&
        !isEmailEmpty &&
        !isPasswordEmpty &&
        !isConfirmPassEmpty &&
        !isUsernameEmpty &&
        isEmailValid &&
        isPasswordValid) {
      return true;
    }
    return false;
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
                    const Padding(padding: EdgeInsets.only(bottom: 50)),
                    TextField(
                      controller: _usernameController,
                      style: GoogleFonts.montserrat(color: Colors.white),
                      decoration: InputDecoration(
                        hintStyle:
                            const TextStyle(fontSize: 17, color: Colors.white),
                        hintText: "Insert your user username",
                        errorBorder: const UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.red),
                        ),
                        errorText:
                            isUsernameEmpty ? "Username cannot be empty" : null,
                        suffixIcon: const Icon(
                          Icons.person_2_outlined,
                          color: Colors.white,
                        ),
                        border: InputBorder.none,
                        contentPadding: const EdgeInsets.all(20),
                      ),
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
                            ? "Email cannot be empty"
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
                        errorText: isPasswordEmpty
                            ? "Password cannot be empty"
                            : !isPasswordValid
                                ? "Your password must contain 1 Uppercase, 1 lowercase, number and a symbol."
                                : null,
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
                            : !isPasswordSame
                                ? "The passwords are not the same."
                                : null,
                        suffixIcon: const Icon(Icons.lock, color: Colors.white),
                        border: InputBorder.none,
                        contentPadding: const EdgeInsets.all(20),
                      ),
                    ),
                    const Padding(padding: EdgeInsets.all(10)),
                    ElevatedButton(
                      onPressed: () async {
                        _checkInput();
                        Debug.printLog("Clicked Register.");
                        if (validateInputs()) {
                          await BackendUtilities.checkBackendHealth()
                              .then((bool isConnected) {
                            if (!isConnected) {
                              loginFailAlert(context,
                                  "connection to server could not be established. try again later.");
                            }
                          });
                          UserModel newUser = UserModel(
                              _usernameController.text,
                              _emailController.text,
                              _passController[0].text,
                              true);
                          UserController.createNewUser(pb, newUser);
                        }
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
        },
      );
}
