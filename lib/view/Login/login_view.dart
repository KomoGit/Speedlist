import 'package:blurrycontainer/blurrycontainer.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:speedlist/Utilities/backend_utilities.dart';
import 'package:speedlist/Utilities/user_utilities.dart';
import 'package:speedlist/controller/user_controller.dart';
import 'package:speedlist/model/user.dart';
import 'package:speedlist/view/Login/login_forgot_password.dart';
import 'package:speedlist/view/home.dart';
import 'package:speedlist/view/register_view.dart';
import 'package:speedlist/view/widgets/Login%20Widgets/oauth_login_buttons.dart';

import '../../Utilities/login_utilities.dart';

LoginUtilities loginUtilities = LoginUtilities();
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
      child: const LoginPageInput(),
    );
  }
}

class LoginPageInput extends StatefulWidget {
  const LoginPageInput({super.key});

  @override
  State<LoginPageInput> createState() => _LoginPageInputState();
}

class _LoginPageInputState extends State<LoginPageInput> {
  late UserModel user;
  late dynamic connectivityResult;
  bool _isEmailEmpty = false;
  bool _isPassEmpty = false;
  bool _isEmailValid = true;

  @override
  void initState() {
    super.initState();
    _checkConnectivity();
  }

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passController.dispose();
  }

  Future<ConnectivityResult> _checkConnectivity() async {
    try {
      connectivityResult = await (Connectivity().checkConnectivity());
      return connectivityResult;
    } catch (e) {
      throw Exception(e);
    }
  }

  void _checkInput() {
    setState(() {
      _isEmailEmpty = _emailController.text.isEmpty;
      _isPassEmpty = _passController.text.isEmpty;
      _isEmailValid = loginUtilities.emailValidator(_emailController.text);
      return;
    });
  }

  bool _validateInputs() {
    if (!_isEmailEmpty && !_isPassEmpty && _isEmailValid) {
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
                      controller: _passController,
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
                            _isPassEmpty ? "Password cannot be empty" : null,
                        suffixIcon: const Icon(Icons.lock_open_outlined,
                            color: Colors.white),
                        border: InputBorder.none,
                        contentPadding: const EdgeInsets.all(20),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () async {
                        //These two codes are repeated heavily. Find a way to fix it
                        _checkConnectivity();
                        if (connectivityResult == ConnectivityResult.none) {
                          loginFailAlert(context,
                              "You are not connected to the internet. Turn on mobile network or WiFi");
                          return;
                        }
                        _checkInput();
                        if (_validateInputs()) {
                          await BackendUtilities.getBackendStatus().then(
                            (isConnected) {
                              if (!isConnected) {
                                loginFailAlert(context,
                                    "Connection to server could not be established. Try again later.");
                              }
                            },
                          ); //Store this inside a global variable that is shared between pages of the application. Use global model and check if user is verified.
                          try {
                            // ignore: unused_local_variable
                            user = await UserController.authUser(
                              BackendUtilities.getBackendAccess(),
                              _emailController.text.trim(),
                              _passController.text.trim(),
                            );
                            UserUtilities.user = user;
                            if (mounted) {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const Home(),
                                ),
                              );
                            }
                          } catch (e) {
                            String errmsg = loginUtilities.formatErrorMessage(
                              e.toString(),
                            );
                            if (mounted) {
                              await loginFailAlert(context,
                                  "$errmsg. Check your email or password for errors.");
                            }
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
                        if (connectivityResult == ConnectivityResult.none) {
                          loginFailAlert(context,
                              "You are not connected to the internet. Turn on mobile network or WiFi");
                          return;
                        }
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const Register(),
                          ),
                        );
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
                              ),
                            ),
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
            ),
            onPressed: () async {
              if (connectivityResult == ConnectivityResult.none) {
                loginFailAlert(context,
                    "You are not connected to the internet. Turn on mobile network or WiFi");
                return;
              }
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const ForgotPassword()));
            },
          ),
          TextButton(
            onPressed: () {
              if (connectivityResult == ConnectivityResult.none) {
                loginFailAlert(context,
                    "You are not connected to the internet. Turn on mobile network or WiFi");
                return;
              }
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const Home()));
            },
            child: const Text(
              "View without logging in",
              style: TextStyle(fontSize: 12, color: Colors.white),
            ),
          )
        ],
      ),
    );
  }

  //Find a way to ensure we can make this into a reusable widget.
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
                    child: const Text("Ok"))
              ],
            ),
          );
        },
      );
}
