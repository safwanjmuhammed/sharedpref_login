import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

Future<List<dynamic>> photos() async {
  Dio service = Dio();
  String url = 'https://jsonplaceholder.typicode.com/photos';
  final response = await service.get(url);
  print(response.data);
  final List data = response.data;
  print(data[0]['id'].toString());
  return data;
}

class SecondPage extends StatefulWidget {
  const SecondPage({super.key});

  @override
  State<SecondPage> createState() => _SecondPageState();
}

class _SecondPageState extends State<SecondPage> {
  List<dynamic> data = [];

  //
  Future<void> getPhotos() async {
    List datax = await photos();

    setState(() {
      data = datax;
    });
  }

  @override
  void initState() {
    super.initState();
    getPhotos();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: [
        Expanded(
          child: ListView.builder(itemBuilder: (context, index) {
            return Card(
              child: Text(data[index]['id'].toString()),
            );
          }),
        ),
      ],
    ));
  }
}
