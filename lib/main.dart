import 'package:flutter/material.dart';
import 'package:login_page/screens/splash.dart';

// ignore: constant_identifier_names
const SAVE_KEY_NAME = "UserLoggedIn";

void main(List<String> args) {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Login Sample',
      theme: ThemeData(primarySwatch: Colors.blue),
      debugShowCheckedModeBanner: false,
      home: const ScreenSplash(),
    );
  }
}
