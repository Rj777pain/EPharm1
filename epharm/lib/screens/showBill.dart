import 'package:epharm/api/api.dart';
import 'package:epharm/utils/bill.dart';
import 'package:epharm/utils/pres.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class showBill extends StatefulWidget {
  @override
  _showBillState createState() => _showBillState();
}

class _showBillState extends State<showBill> {
  api ap=api();
  var id;
  List<Pres> p=[];
  Bill _bill;
  @override
  Widget build(BuildContext context) {
    UpdateMax();
    return Container(
      child: ListView(
        children: [
          RaisedButton(
            child: Text("Submit"),
            onPressed:()async{
              p=await ap.getPres(id);
              _bill=await ap.getBill(id);
              print(p);
              print(_bill);
            }
          )
        ],
      ),
    );
  }

  void UpdateMax() async {
    id = await ap.getMax();
    id--;
  }
}