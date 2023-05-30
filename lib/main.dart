import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sharedpref_login/home.dart';
import 'package:sharedpref_login/login.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  MyApp();

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String? value;
  Future checkIfloggedin() async {
    SharedPreferences prefss = await SharedPreferences.getInstance();
    var emailgot = prefss.getString("email");
    setState(() {
      value = emailgot;
    });

    print(value);
  }

  @override
  void initState() {
    checkIfloggedin();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: value == null ? LoginScreen() : MyHomePage(),
    );
  }
}
