import 'package:epharm/api/api.dart';
import 'package:epharm/screens/bodyScreen.dart';
import 'package:epharm/screens/buymed.dart';
import 'package:epharm/screens/showBill.dart';
import 'package:epharm/utils/patient.dart';
import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  Login({Key key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _formKey = GlobalKey<FormState>();
  User user;
  api ap = api();
  TextEditingController _uname = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Form(
          key: _formKey,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 40.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("E PHARM",style:TextStyle(fontSize: 40,fontWeight:FontWeight.bold,color:Colors.teal[900])),
                SizedBox(height: 10.0,),
              Container(
                height: 50.0,
                child: TextFormField(
                  controller: _uname,
                  decoration: InputDecoration(
                      // hintText: 'Phone',
                      hintText: "username",
                      prefixIcon: Icon(Icons.person, color: Colors.teal[900]),
                      fillColor: Colors.transparent,
                      filled: true,
                      hintMaxLines: 1,
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25),
                        borderSide:
                            BorderSide(color: Colors.teal[900], width: 1.0),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25),
                        borderSide:
                            BorderSide(color: Colors.teal[900], width: 1.0),
                      )),
                  keyboardType: TextInputType.text,
                  validator: (val) {
                    return null;
                  },
                ),
              ),
              SizedBox(
                height: 30,
              ),
              RaisedButton(
                onPressed: () async {
                  user = await ap.getUser(_uname.text);
                  print(user.pname + (user.pid).toString());
                  Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return 
                        bodyScreen(user:user);
                        // BuyMed(user:user); //to next page
                      }));
                },
                color: Colors.teal[900],
                elevation: 6.0,
                padding: EdgeInsets.symmetric(horizontal: 20),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25),
                ),
                textColor: Colors.white,
                child: Container(
                  width: 330,
                  height: 50,
                  alignment: Alignment.center,
                  child: Text("Login",
                      style: TextStyle(fontSize: 18.0, color: Colors.white,fontWeight: FontWeight.bold)),
                ),
              ),
            ]),
          )),
    );
  }
}
