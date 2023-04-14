import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ivy/view/dashboardScreen.dart';
import 'package:ivy/view/loginScreen.dart';

import './view/signupScreen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      home: LoginScreen(),
      getPages: [
        GetPage(name: "/login", page: (() => LoginScreen())),
        GetPage(name: "/register", page: (() => SignupScreen())),
        GetPage(name: "/dashboard", page: (() => DashboardScreen()))
      ],
    );
  }
}
