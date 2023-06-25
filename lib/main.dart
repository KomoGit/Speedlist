import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:speedlist/view/Login/login_view.dart';

import 'controller/user_preferences_db_controller.dart';

DBAccess dbAccess = DBAccess();
main(){
  WidgetsFlutterBinding.ensureInitialized();
  //Initialize dbController from DBAccess here.
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Project - Speedlist',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const LoginPage(),
    );
  }
}

