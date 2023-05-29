import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sharedpref_login/home.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({
    super.key,
  });

  @override
  State<LoginScreen> createState() => LoginScreenState();
}

class LoginScreenState extends State<LoginScreen> {
  TextEditingController emailcontroller = TextEditingController();
  bool loginstatus = false;

  //Function for saving email eneterd to sharedpreference
  void saveEmail(email) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var enteredemail = prefs.setString('email', email);
    setState(() {
      loginstatus = true;
    });
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return MyHomePage();
    }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: emailcontroller,
              decoration: InputDecoration(
                hintText: 'Email',
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                  onPressed: () {
                    if (emailcontroller.text.isEmpty) {
                      print("FIELD IS EMPTY");
                    } else {
                      saveEmail(emailcontroller.text);
                    }
                  },
                  child: Text("LOGIN")),
            ),
          ],
        ),
      ),
    );
  }
}
