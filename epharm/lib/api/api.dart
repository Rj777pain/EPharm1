import 'package:epharm/utils/bill.dart';
import 'package:epharm/utils/patient.dart';
import 'package:epharm/utils/pres.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class api{
  String _baseUrl = "http://192.168.43.19:5000";
  // fetching prescription
  Future<dynamic> getPres(int prid) async {
    // print('Api Get, url $url');
    List pres=[];
    var responseJson;

    final response = await http.post(_baseUrl + '/get_pres',
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8'
        },
        body: jsonEncode(<String, int>{'prid': prid}));
    print(response.statusCode);
    if (response.statusCode == 200) {
      responseJson = json.decode(response.body.toString());
      print('api get recieved!');
      // print(responseJson);
      pres = [];
      for (var i in responseJson) {
        print(i);
        pres.add(Pres.fromMap(i));
      }
      print(pres);
    } else if (response.statusCode == 500) {
      responseJson = json.decode(response.body.toString());
      print('api get recieved!');
      print(responseJson);
    }

    // print('api get recieved!');
    // print(responseJson);
  }

  // inserting prescription
  Future<void> inPres(int max,List p) async {
    
    // var drugs={'TA':1,'TB':2,'TC':3,'TD':4,'TE':5,'TF':6,'TG':7,'TH':8};
    var responseJson;
    var js;
    for (var i in p) {
      js = i.toJson();
      final response = await http.post(_baseUrl + '/in_pres',
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8'
          },
          body: js);
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
    }
  }

// inserting bill
Future<dynamic> inBill(int max) async {
    // print('Api Get, url $url');
    var responseJson;

    final response = await http.post(_baseUrl + '/in_bill',
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8'
        },
        body: jsonEncode(<String, int>{'prid': max}));
    print(response.statusCode);
    if (response.statusCode == 200) {
      responseJson = json.decode(response.body.toString());
      print('api get recieved!');
      print(responseJson);

      print('api get recieved!');
    } else if (response.statusCode == 500) {
      responseJson = json.decode(response.body.toString());
      print(responseJson);
      print('api get recieved!');
      // print(responseJson);
    }

    // print('api get recieved!');
    // print(responseJson);
  }

  // getting current presciption id
  Future<dynamic> getMax() async {
    // print('Api Get, url $url');
    var responseJson;
    var max=0;
    final response = await http.post(
      _baseUrl + '/max_p',
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8'
      },
    );
    print(response.statusCode);
    if (response.statusCode == 200) {
      responseJson = json.decode(response.body.toString());
      print('api get recieved!');
      // print(responseJson);

      max = responseJson[0]['max'] + 1;
      print(max);
    } else if (response.statusCode == 500) {
      responseJson = json.decode(response.body.toString());
      print('api get recieved!');
      print(responseJson);
    }
    return(max);
    // print('api get recieved!');
    // print(responseJson);
  }

  // fetching bill
  Future<dynamic> getBill(int prid) async {
    // print('Api Get, url $url');
    var responseJson;
    var bill;
    final response = await http.post(_baseUrl + '/get_bill',
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8'
        },
        body: jsonEncode(<String, int>{'prid': prid}));
    print(response.statusCode);
    if (response.statusCode == 200) {
      responseJson = json.decode(response.body.toString());
      print('api get recieved!');
      print(responseJson);

      bill = Bill.fromJson(response.body.toString());
      
      print(bill);
      print('api get recieved!');
      return(bill);
    } else if (response.statusCode == 500) {
      responseJson = json.decode(response.body.toString());
      print(responseJson);
      print('api get recieved!');
      // print(responseJson);
    }

    // print('api get recieved!');
    // print(responseJson);
  }

  // check user
  Future<dynamic> getUser(String pname) async {
    // print('Api Get, url $url');
    var responseJson;
    var user;
    final response = await http.post(_baseUrl + '/user',
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8'
        },
        body: jsonEncode(<String, String>{'pname': pname}));
    print(response.statusCode);
    if (response.statusCode == 200) {
      // responseJson = json.decode(response.body.toString());
      print('api get recieved!');
      // print(responseJson);

      user = User.fromJson(response.body.toString());

      print(user);
      return(user);
      
    } else if (response.statusCode == 500) {
      responseJson = json.decode(response.body.toString());
      print('api get recieved!');
      print(responseJson);
    }

    // print('api get recieved!');
    // print(responseJson);
  }
}