import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:societymanagement/Components/CustomAppBar.dart';
import 'package:societymanagement/Components/RaisedBtn.dart';
import 'package:societymanagement/Components/TextField.dart';
import 'package:societymanagement/Screens/Bills.dart';
import 'package:societymanagement/Screens/Notice.dart';
import 'package:societymanagement/Utils/GetDetails.dart';
import 'package:societymanagement/Utils/GetSharedPref.dart';

class AddBill extends StatefulWidget {
  static final String id = "AddBill";
  @override
  _AddBillState createState() => _AddBillState();
}

class _AddBillState extends State<AddBill> {
  FocusNode amountFN;
  String amount, catAmount, category = "Select";
  List<IconData> icons = [Icons.arrow_drop_down, Icons.lightbulb, Icons.water_damage_outlined, Icons.security, Icons.miscellaneous_services, Icons.event, Icons.festival];
  IconData icon;
  bool isLoading = false;

  @override
  void initState() {
    amountFN = FocusNode();
    initial();
    super.initState();
  }

  @override
  void dispose() {
    amountFN.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(56),
          child: appBar(context, "Add Bill"),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 10,),
              Center(child: Text("Add new Bill!!", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 30),)),
              SizedBox(height: 30,),
              kTextField(context, "Enter Amount", Icon(Icons.description), amountFN, null, TextInputType.number, (value){amount = value;}, TextInputAction.done),
              SizedBox(height: 25,),
              Center(
                child: DropdownButton<String>(
                  value: category,
                  onChanged: (String newValue) {
                    setState(() {
                      category = newValue;
                    });
                  },
                  items: <String>["Select", "Electricity", "Water", "Security", "Maintenance", "Events", "Festivals"]
                    .map<DropdownMenuItem<String>>((String value) {
                      if(value == "Select") {icon = icons[0];}
                      else if(value == "Electricity") {icon = icons[1];}
                      else if(value == "Water") {icon = icons[2];}
                      else if(value == "Security") {icon = icons[3];}
                      else if(value == "Maintenance") {icon = icons[4];}
                      else if(value == "Events") {icon = icons[5];}
                      else if(value == "Festivals") {icon = icons[6];}
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Row(
                          children: <Widget>[
                            Icon(icon, size: 35,),
                            SizedBox(width: 20,),
                            Text(value),
                          ],
                        ),
                      );
                    })
                    .toList(),
                ),
              ),
              SizedBox(height: 25,),
              isLoading
                ? Center(child: SizedBox(width: MediaQuery.of(context).size.width*0.1, child: CircularProgressIndicator()))
                : kRaisedButton(200, "Add", () {check();}),
              SizedBox(height: 10,),
            ],
          )
        ),
      ),
    );
  }

  getDueAmount(String categoryGet) async {
    collectionReference.doc("Bill").collection("2020-11").doc(category).get().then((value) {
      catAmount = value.data()["amount"];
      int newAmount = int.parse(amount) + int.parse(catAmount);
      collectionReference.doc("Bill").collection("2020-11").doc(category).set({
        "amount": (int.parse(amount) + int.parse(catAmount)).toString(),
      });
    });
  }

  void check() {
    if(amount.toString() == null) {
      Fluttertoast.showToast(msg: "Enter amount...");
    } else {
      setState(() {isLoading = true;});
      getDueAmount(category);
      collectionReference.doc("Bill").collection(date).doc().set({
        "amount": amount.toString(),
        "category": category,
      }).then((value) {
        setState(() {isLoading = false;});
        Fluttertoast.showToast(msg: "New Bill Added!");
        Navigator.popAndPushNamed(context, Bills.id);
      });
    }
  }
}