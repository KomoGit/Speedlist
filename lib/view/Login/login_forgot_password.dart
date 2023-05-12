import 'package:blurrycontainer/blurrycontainer.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:speedlist/debug/print.dart';

final TextEditingController _emailController = TextEditingController();

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
        child: const ForgotPasswordInput());
  }
}

class ForgotPasswordInput extends StatefulWidget {
  const ForgotPasswordInput({super.key});

  @override
  State<ForgotPasswordInput> createState() => _ForgotPasswordInputState();
}

class _ForgotPasswordInputState extends State<ForgotPasswordInput> {
  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
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
              child: SizedBox(
                width: 310,
                height: 310,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const Padding(padding: EdgeInsets.all(10)),
                        IconButton(
                            onPressed: () => Navigator.pop(
                                context), //Navigator.push(context, MaterialPageRoute(builder: (context) = > const LoginPage())),
                            icon: const Icon(
                              Icons.arrow_back,
                              color: Colors.white,
                            )),
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
                            borderSide: BorderSide(color: Colors.red)),
                        errorText: _emailController.text.isEmpty
                            ? "Please insert your email you used to register"
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
                      onPressed: () {
                        Debug.printLog("Clicked on reset password");
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
}
