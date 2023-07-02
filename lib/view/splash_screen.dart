import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import '../Utilities/user_utilities.dart';
import 'Login/login_view.dart';
import 'home.dart';

const int splashDuration = 5300; // 5300 last working number.

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  late Widget homeWidget;

  @override
  void initState(){
    super.initState();
    _determineUserLogin();
  }

  void _determineUserLogin() async{
    await Future.delayed(const Duration(milliseconds: splashDuration),(){});
    final Widget homeWidget = UserUtilities.user.id == "000" ? const LoginPage() : const Home();
    _navigateOutOfSplash(homeWidget);
  }

  void _navigateOutOfSplash(Widget homeWidget){
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> homeWidget));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Lottie.asset("assets/images/calendar_lot.json"),
            ),
            Center(
                child: Text("Speedlist",style: GoogleFonts.bebasNeue(fontSize: 42, color: Colors.white)
                )
            ),
          ],
      ),
    );
  }
}