import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:speedlist/view/Login/login_view.dart';

import 'controller/user_preferences_db_controller.dart';

late PreferencesDBController internalDBController;

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  internalDBController = await PreferencesDBController.init();
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
      home: const LoginPage(), //const Home(),
    );
  }
}
