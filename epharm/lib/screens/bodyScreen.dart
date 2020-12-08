import 'package:epharm/api/api.dart';
import 'package:epharm/utils/patient.dart';
import 'package:flutter/material.dart';

class bodyScreen extends StatefulWidget {
  User user;
  bodyScreen({this.user});
  @override
  _bodyScreenState createState() => _bodyScreenState();
}

class _bodyScreenState extends State<bodyScreen> {
  User us;
  var max;
  TextStyle textStyle = TextStyle(
      fontSize: 20.0, fontWeight: FontWeight.w500, color: Colors.teal[900]);
  api ap = api();
  @override
  Widget build(BuildContext context) {
    us = widget.user;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        
        // toolbarHeight: 100,
        title: Text("E Pharm"),
        
        
        backgroundColor: Colors.teal[900],
        elevation: 6.0,
      ),
      body: Container(
        // color: Colors.teal[200],
        child: Container(
          // height: 200,
          padding: EdgeInsets.symmetric(horizontal: 10.0),
          child: SingleChildScrollView(
                      child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                
                Card(
                  color: Colors.white,
                  elevation: 12.0,
                  shape: RoundedRectangleBorder(
                    borderRadius:BorderRadius.circular(25)
                  ),
                  child: ListTile(
                    title: Padding(
                      padding: const EdgeInsets.only(left:18.0),
                      child: Text(
                        us.pname,
                        style: textStyle.copyWith(fontSize:25),
                      ),
                      
                    ),
                    trailing:Image.asset("images/kiss.png"),
                    subtitle: Padding(
                      padding: const EdgeInsets.only(left:18.0),
                      child: Text("Age: ${us.age}",style: textStyle,),
                    ),
                    leading: CircleAvatar(
                      radius: 30.0,
                      backgroundImage: AssetImage("images/img.png"),
                    ),
                  ),
                ),
                
                Image.asset("images/Ph.png"),
                Row(
                  
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                  RaisedButton(
                  onPressed: () {},
                  color: Colors.teal[200],
                  elevation: 6.0,
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(topLeft: Radius.circular(25),bottomLeft: Radius.circular(25)),
                  ),
                  textColor: Colors.white,
                  child: Container(
                    width: 100,
                    height: 50,
                    alignment: Alignment.center,
                    child: Text("Buy",
                        style: TextStyle(fontSize: 18.0, color: Colors.teal[900],fontWeight: FontWeight.bold)),
                  ),
                ),
                SizedBox(width: 5.0,),
                RaisedButton(
                  onPressed: () {},
                  color: Colors.teal[900],
                  elevation: 6.0,
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(topRight: Radius.circular(25),bottomRight: Radius.circular(25)),
                  ),
                  textColor: Colors.white,
                  child: Container(
                    width: 100,
                    height: 50,
                    alignment: Alignment.center,
                    child: Text("Bill",
                        style: TextStyle(fontSize: 18.0, color: Colors.white,fontWeight: FontWeight.bold)),
                  ),
                ),
                ],),
                SizedBox(height: 10.0,)
              ],
            ),
          ),
        ),
      ),
    );
  }

  void UpdateMax() async {
    max = await ap.getMax();
  }
}
