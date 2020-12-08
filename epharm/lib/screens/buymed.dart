import 'package:epharm/api/api.dart';
import 'package:epharm/utils/patient.dart';
import 'package:epharm/utils/pres.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BuyMed extends StatefulWidget {
  User user;
  BuyMed({this.user});
  @override
  _BuyMedState createState() => _BuyMedState();
}

class _BuyMedState extends State<BuyMed> {
  User us;
  api ap = api();
  var max;
  int cnt = 1;
  Pres p1;
  List<Pres> p = [];
  var drug = ['TA', 'TB', 'TC', 'TD', 'TE', 'TF', 'TG', 'TH'];
  String _currItem = 'TA';
  @override
  Widget build(BuildContext context) {
    
    UpdateMax();
    us = widget.user;

    return Container(
      color: Colors.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
              child: ListView.builder(
                  itemCount: cnt,
                  itemBuilder: (BuildContext context, int position) {
                    return Container(
                      child: Card(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Container(
                              width: 100,
                              child: Container(
                                width: 50,
                                child: TextFormField(
                                  // controller: _uname,
                                  decoration: InputDecoration(
                                      // hintText: 'Phone',
                                      hintText: "dr",
                                      fillColor: Colors.transparent,
                                      filled: true,
                                      hintMaxLines: 1,
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(25),
                                        borderSide: BorderSide(
                                            color: Color(0xff002730),
                                            width: 1.0),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(25),
                                        borderSide: BorderSide(
                                            color: Color(0xff002730),
                                            width: 1.0),
                                      )),
                                  keyboardType: TextInputType.text,
                                  onChanged: (val){
                                    _currItem=val;
                                  },
                                  validator: (val) {
                                    return null;
                                  },
                                ),
                              ),
                            ),
                            Container(
                              width: 50,
                              child: TextFormField(
                                // controller: _uname,
                                decoration: InputDecoration(
                                    // hintText: 'Phone',
                                    hintText: "us",
                                    fillColor: Colors.transparent,
                                    filled: true,
                                    hintMaxLines: 1,
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(25),
                                      borderSide: BorderSide(
                                          color: Color(0xff002730), width: 1.0),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(25),
                                      borderSide: BorderSide(
                                          color: Color(0xff002730), width: 1.0),
                                    )),
                                keyboardType: TextInputType.text,
                                validator: (val) {
                                  return null;
                                },
                              ),
                            ),
                            RaisedButton(
                                child: Text("add"),
                                onPressed: () {
                                  setState(() {
                                    cnt++;
                                    // print(_currItem);
                                    p1=Pres(
                                        prid: max,
                                        pid: us.pid,
                                        drug: this._currItem,
                                        doctor: "Dr Hari",
                                        quantity: 10,
                                        price: 0);
                                    UpdatePres(p1);
                                  });
                                  print(p);
                                  
                                }),
                          ],
                        ),
                      ),
                    );
                  })),
          RaisedButton(
              child: Text("submit"),
              onPressed: () async {
                
                await ap.inPres(max, p);
                await ap.inBill(max);
                // print("No error");
              }),
        ],
      ),
    );
  }

  void UpdatePres(Pres temp){
    p.add(temp);
  }
  void UpdateMax() async {
    max = await ap.getMax();
  }
}
