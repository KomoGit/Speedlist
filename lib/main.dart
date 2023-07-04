import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:speedlist/view/splash_screen.dart';

import 'Utilities/user_utilities.dart';
import 'controller/internal_db_controller.dart';
import 'controller/user_controller.dart';
import 'debug/print.dart';
import 'model/user.dart';

main(){
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  _autoLogin();
  runApp(const MyApp());
}

void _autoLogin() async {
  try{
    UserForAutoLogin usr = await InternalDBController.instance.getUserFromMemory();
    UserUtilities.user = await UserController.auth(usr.userEmailAddress,usr.password);
  }catch(e){
    Debug.printLog(e);
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const Splash(),
    );
  }
}