import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sharedpref_login/login.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({
    super.key,
  });

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String texttodisplay = '';
  //function for getting the data from sharedpref
  Future getemail() async {
    SharedPreferences prefss = await SharedPreferences.getInstance();
    var emailgot = prefss.getString("email");
    setState(() {
      texttodisplay = emailgot!;
    });
  }

  @override
  void initState() {
    getemail();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(texttodisplay),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                  onPressed: () async {
                    SharedPreferences pref =
                        await SharedPreferences.getInstance();
                    pref.remove("email");
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return LoginScreen();
                    }));
                  },
                  child: Text('LOGOUT')),
            )
          ],
        ),
      ),
    );
  }
}
