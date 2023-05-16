import 'package:blurrycontainer/blurrycontainer.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:speedlist/Utilities/login_utilities.dart';
import 'package:speedlist/controller/user_controller.dart';

import '../../Utilities/backend_utilities.dart';

LoginUtilities loginUtilities = LoginUtilities();
late TextEditingController _emailController;
late bool _isEmailValid;
bool _isEmailEmpty = true;

class ForgotPassword extends StatelessWidget {
  const ForgotPassword({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
            image: AssetImage("assets/images/pexels-photo-1379636.jpeg"),
            fit: BoxFit.cover),
      ),
      child: const ForgotPasswordInput(),
    );
  }
}

class ForgotPasswordInput extends StatefulWidget {
  const ForgotPasswordInput({super.key});

  @override
  State<ForgotPasswordInput> createState() => _ForgotPasswordInputState();
}

class _ForgotPasswordInputState extends State<ForgotPasswordInput> {
  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
    _isEmailValid = loginUtilities.emailValidator(_emailController.text);
  }

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
  }

  void checkInput() {
    setState(
      () {
        _isEmailEmpty = _emailController.text.isEmpty;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    _isEmailValid = loginUtilities.emailValidator(_emailController.text);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.transparent,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: BlurryContainer.square(
              child: SizedBox(
                width: 310,
                height: 310,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const Padding(
                          padding: EdgeInsets.all(10),
                        ),
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
                      "Forgot my password",
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
                        errorText: _isEmailEmpty
                            ? "Please insert your email used in registration"
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
                    ElevatedButton(
                      onPressed: () async {
                        checkInput();
                        if (!_isEmailEmpty && _isEmailValid) {
                          await BackendUtilities.getBackendStatus().then(
                            (isConnected) {
                              if (!isConnected) {
                                loginFailAlert(context,
                                    "Connection to server could not be established. Try again later.");
                              } else {
                                UserController.requestUserPasswordReset(
                                    BackendUtilities.getBackendAccess(),
                                    _emailController.text);
                              }
                            },
                          );
                        }
                      },
                      style: ButtonStyle(
                        shape: MaterialStatePropertyAll(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                        ),
                      ),
                      child: const Text("Reset my password"),
                    )
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
                  child: const Text("Ok."),
                )
              ],
            ),
          );
        },
      );
}
