import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _baseUrl = "http://192.168.43.19:5000";
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: Container(
              child: RaisedButton(
            onPressed: () {
              get();
            },
            child: Text("Submit"),
          )),
        ),
      ),
    );
  }

  Future<dynamic> get() async {
    // print('Api Get, url $url');
    var responseJson;

    final response = await http.post(_baseUrl + '/aaa',
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8'
        },
        body: jsonEncode(<String, String>{'usr': "aaa"}));
    print(response.statusCode);
    if (response.statusCode == 200) {
      responseJson = json.decode(response.body.toString());
      print('api get recieved!');
      print(responseJson);
    } else if (response.statusCode == 500) {
      responseJson = json.decode(response.body.toString());
      print('api get recieved!');
      print(responseJson);
    }

    // print('api get recieved!');
    // print(responseJson);
  }
}
