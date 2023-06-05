import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sharedpref_login/login.dart';
import 'package:http/http.dart' as http;
import 'package:sharedpref_login/model/photomodel.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({
    super.key,
  });

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late List<PhotoModel> data;
//Apicall
  Future<List<PhotoModel>> ApiCall() async {
    var response = await http
        .get(Uri.parse("https://jsonplaceholder.typicode.com/photos"));
    print(response.body);

    List jsonResponse = jsonDecode(response.body);
    List<PhotoModel> toList =
        jsonResponse.map((e) => PhotoModel.fromJson(e)).toList();

    if (response.statusCode == 200) {
      return toList;
    } else {
      throw Exception('API CALL FAILED');
    }
  }

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
      body: SafeArea(
        child: FutureBuilder(
            future: ApiCall(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                data = snapshot.data!;
                print("THEFUCKINGDATA" + data[0].url);
                return ListV(data);
                // return Column(
                //   children: [
                //     Text(texttodisplay),
                //     Padding(
                //       padding: const EdgeInsets.all(8.0),
                //       child: ElevatedButton(
                //           onPressed: () async {
                //             SharedPreferences pref =
                //                 await SharedPreferences.getInstance();
                //             pref.remove("email");
                //             Navigator.pushReplacement(context,
                //                 MaterialPageRoute(builder: (context) {
                //               return LoginScreen();
                //             }));
                //           },
                //           child: Text('LOGOUT')),
                //     ),
                //   ],
                // );
              } else {
                (snapshot.hasError);
              }

              return Center(child: CircularProgressIndicator());
            }),
      ),
    );
  }
}

Widget ListV(List<PhotoModel> data) {
  return ListView.builder(
      itemCount: data.length,
      itemBuilder: (BuildContext context, int index) {
        return ListTile(
            leading: CircleAvatar(
          backgroundImage: NetworkImage(data[index].thumbnailUrl),
        ));
      });
}
