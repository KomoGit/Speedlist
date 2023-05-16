import 'package:blurrycontainer/blurrycontainer.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:speedlist/controller/user_controller.dart';
import 'package:speedlist/model/user.dart';

import '../Utilities/backend_utilities.dart';
import '../Utilities/login_utilities.dart';

LoginUtilities loginUtilities = LoginUtilities();
late TextEditingController _usernameController;
late TextEditingController _emailController;
List<TextEditingController> _passController = List.generate(
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
  bool _isUsernameEmpty = false;
  bool _isEmailEmpty = false;
  bool _isPasswordEmpty = false;
  bool _isConfirmPassEmpty = false;
  //To prevent immediate error and confuse the user, we keep these as true.
  //Except in forgot password page which helps specify the issue to user.
  bool _isPasswordValid = true;
  bool _isEmailValid = true;
  bool _isPasswordSame = true;

  @override
  void initState() {
    super.initState();
    _usernameController = TextEditingController();
    _emailController = TextEditingController();
    _passController =
        List.generate(2, (i) => TextEditingController(), growable: false);
  }

  @override
  void dispose() {
    super.dispose();
    _usernameController.dispose();
    _emailController.dispose();
    _passController[0].dispose();
    _passController[1].dispose();
  }

  void _checkInput() {
    setState(
      () {
        _isUsernameEmpty = _usernameController.text.isEmpty;
        _isEmailEmpty = _emailController.text.isEmpty;
        _isPasswordEmpty = _passController[0].text.isEmpty;
        _isConfirmPassEmpty = _passController[1].text.isEmpty;
        _isPasswordValid =
            loginUtilities.passwordValidator(_passController[0].text);
        _isPasswordSame = loginUtilities.arePasswordsSame(
            _passController[0].text, _passController[1].text);
        _isEmailValid = loginUtilities.emailValidator(_emailController.text);
        return;
      },
    );
  }

  bool validateInputs() {
    if (!_isUsernameEmpty &&
        !_isEmailEmpty &&
        !_isPasswordEmpty &&
        !_isConfirmPassEmpty &&
        !_isUsernameEmpty &&
        _isEmailValid &&
        _isPasswordValid &&
        _isPasswordSame) {
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        IconButton(
                          onPressed: () => Navigator.pop(context),
                          icon: const Icon(
                            Icons.arrow_back,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
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
                        errorText: _isUsernameEmpty
                            ? "Username cannot be empty"
                            : null,
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
                        errorText: _isEmailEmpty
                            ? "Email cannot be empty"
                            : !_isEmailValid
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
                        errorText: _isPasswordEmpty
                            ? "Password cannot be empty"
                            : !_isPasswordValid
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
                        errorText: _isConfirmPassEmpty
                            ? "Please write the password again"
                            : !_isPasswordSame
                                ? "The passwords are not the same."
                                : null,
                        suffixIcon: const Icon(Icons.lock, color: Colors.white),
                        border: InputBorder.none,
                        contentPadding: const EdgeInsets.all(20),
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.all(10),
                    ),
                    ElevatedButton(
                      onPressed: () async {
                        _checkInput();
                        if (validateInputs()) {
                          await BackendUtilities.getBackendStatus().then(
                            (bool isConnected) {
                              if (!isConnected) {
                                loginFailAlert(context,
                                    "Connection to server could not be established. try again later.");
                              }
                            },
                          );
                          List<String> passwords = [
                            _passController[0].text,
                            _passController[1].text
                          ];
                          UserRegisterModel newUser = UserRegisterModel(
                            _usernameController.text.trim(),
                            _emailController.text.trim(),
                            passwords,
                          );
                          await UserController.createNewUser(
                                  BackendUtilities.getBackendAccess(), newUser)
                              .then(
                            (String res) {
                              loginFailAlert(context, res);
                            },
                          );
                        }
                      },
                      //The button stays greyed out even when it is filled correctly. The checkInput method is called only when the button is pressed. Uh Oh.
                      style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5),
                          ),
                          backgroundColor:
                              validateInputs() ? Colors.blue : Colors.grey),
                      child: const Text("Register"),
                    ),
                  ],
                ),
              ),
            ),
          ),
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
