import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:speedlist/Utilities/login_utilities.dart';
import 'package:speedlist/view/Login/login_view.dart';

import 'controller/user_preferences_db_controller.dart';

main(){
  WidgetsFlutterBinding.ensureInitialized();
  _initInternalDB();
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

Future<void> _initInternalDB() async{
  await PreferencesDBController.init();
}