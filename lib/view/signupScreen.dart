// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  TextEditingController _usernameController = TextEditingController();
  TextEditingController _passwordConroller = TextEditingController();

  Future<int> _signup(String username, String password) async {
    try {
      final url =
          Uri.parse("https://taskcon-production.up.railway.app/register");
      final body = json.encode(
          {"username": username, "email": username, "password": password});
      var headers = {'Content-Type': 'application/json'};
      final response = await http.post(url, headers: headers, body: body);

      final data = json.decode(response.body);

      if (response.statusCode == 201) {
        return 201;
      } else if (response.statusCode == 400) {
        return 400;
      } else {
        return 422;
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
                    "Sign up",
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
                        child: TextField(
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
                        child: TextField(
                          controller: _passwordConroller,
                          obscureText: true,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                          ),
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
                                child: Text("Register"),
                                onPressed: (() async {
                                  final response = await _signup(
                                      _usernameController.text,
                                      _passwordConroller.text);

                                  if (response == 201) {
                                    Get.toNamed("/login");
                                  } else {
                                    Get.snackbar(
                                      "Error",
                                      "User Already Exist",
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
                              Get.toNamed("/login");
                            }),
                            child: Text("Already have a account? Login here!")),
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
