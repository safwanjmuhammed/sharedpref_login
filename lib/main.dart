import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sharedpref_login/home.dart';
import 'package:sharedpref_login/login.dart';

Future<void> MyApp() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  var email = prefs.getString("email");
  print(email);
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: email == null ? LoginScreen() : MyHomePage(),
  ));
}
