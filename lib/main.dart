import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:speedlist/view/Login/login_view.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Project - Speelist',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const LoginPage(), //const Home(),
    );
  }
}
