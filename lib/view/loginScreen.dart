// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController _usernameController = TextEditingController();
  TextEditingController _passwordConroller = TextEditingController();

  Future<int> _login(String username, String password) async {
    try {
      final url = Uri.parse("https://taskcon-production.up.railway.app/signin");
      final body = json.encode({"username": username, "password": password});
      var headers = {'Content-Type': 'application/json'};
      final response = await http.post(url, headers: headers, body: body);

      final data = json.decode(response.body);

      if (response.statusCode == 200) {
        return 200;
      } else if (response.statusCode == 400) {
        return 400;
      } else {
        return 400;
      }
    } catch (error) {
      throw (error);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(color: Colors.blue.shade300),
          child: Center(
            child: Container(
              height: 400,
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              margin: EdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(20)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    "Login",
                    style: TextStyle(
                        color: Color.fromRGBO(99, 68, 171, 1),
                        fontSize: 30,
                        fontWeight: FontWeight.w500),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        "Username",
                        style: TextStyle(
                            color: Color.fromRGBO(161, 129, 235, 1),
                            fontSize: 18,
                            fontWeight: FontWeight.w500),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        decoration: BoxDecoration(
                            color: Color.fromRGBO(175, 237, 231, 1),
                            borderRadius: BorderRadius.circular(10)),
                        child: TextFormField(
                          controller: _usernameController,
                          decoration: InputDecoration(border: InputBorder.none),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        "Password",
                        style: TextStyle(
                            color: Color.fromRGBO(161, 129, 235, 1),
                            fontSize: 18,
                            fontWeight: FontWeight.w500),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        decoration: BoxDecoration(
                            color: Color.fromRGBO(175, 237, 231, 1),
                            borderRadius: BorderRadius.circular(10)),
                        child: TextFormField(
                          controller: _passwordConroller,
                          obscureText: true,
                          decoration: InputDecoration(border: InputBorder.none),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Align(
                        alignment: Alignment.center,
                        child: Container(
                            padding: EdgeInsets.symmetric(horizontal: 10),
                            decoration: BoxDecoration(
                                // color: Color.fromRGBO(99, 68, 171, 1),
                                borderRadius: BorderRadius.circular(10)),
                            child: ElevatedButton(
                                child: Text("Login"),
                                onPressed: (() async {
                                  final response = await _login(
                                      _usernameController.text,
                                      _passwordConroller.text);

                                  if (response == 200) {
                                    Get.offNamed("/dashboard",
                                        arguments: _usernameController.text);
                                  } else {
                                    Get.snackbar(
                                      "Error",
                                      "Wrong Credentials",
                                      backgroundColor: Colors.red,
                                      duration: Duration(seconds: 3),
                                      snackPosition: SnackPosition.BOTTOM,
                                    );
                                  }
                                }),
                                style: ElevatedButton.styleFrom(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    backgroundColor:
                                        Color.fromRGBO(99, 68, 171, 1),
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 50, vertical: 20),
                                    textStyle: TextStyle(
                                        fontSize: 22,
                                        fontWeight: FontWeight.bold)))),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Center(
                        child: TextButton(
                            onPressed: (() {
                              Get.toNamed("/register");
                            }),
                            child:
                                Text("Don't have a account? Register here!")),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
