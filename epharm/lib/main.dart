import 'package:epharm/screens/login.dart';
import 'package:epharm/utils/bill.dart';
import 'package:epharm/utils/patient.dart';
import 'package:epharm/utils/pres.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';
import 'package:epharm/api/api.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  List pres=[];
  var bill, user, max;
  api ap=api();
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Center(
          child: Login(),
         
        ),
      ),
    );
  }

  
}
