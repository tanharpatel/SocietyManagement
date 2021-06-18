import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:societymanagement/Components/CustomAppBar.dart';
import 'package:societymanagement/Components/RaisedBtn.dart';
import 'package:societymanagement/Components/TextField.dart';
import 'package:societymanagement/Screens/Complaints.dart';
import 'package:societymanagement/Screens/Notice.dart';
import 'package:societymanagement/Utils/GetDetails.dart';
import 'package:societymanagement/Utils/GetSharedPref.dart';

class AddComplaint extends StatefulWidget {
  static final String id = "AddComplaint";
  @override
  _AddComplaintState createState() => _AddComplaintState();
}

class _AddComplaintState extends State<AddComplaint> {
  FocusNode titleFN, subtitleFN;
  String title, subtitle;
  bool isLoading = false;

  @override
  void initState() {
    titleFN = FocusNode();
    subtitleFN = FocusNode();
    initial();
    super.initState();
  }

  @override
  void dispose() {
    titleFN.dispose();
    subtitleFN.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(56),
          child: appBar(context, "Register Complaint"),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 10,),
              Center(child: Text("Register Complaint!!", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 30),)),
              SizedBox(height: 30,),
              kTextField(context, "Complaint Title", Icon(Icons.title), titleFN, subtitleFN, TextInputType.text, (value){title = value;}, null),
              SizedBox(height: 20,),
              kTextField(context, "Complaint Description", Icon(Icons.description), subtitleFN, null, TextInputType.text, (value){subtitle = value;}, TextInputAction.done),
              SizedBox(height: 25,),
              isLoading
                ? Center(child: SizedBox(width: MediaQuery.of(context).size.width*0.1, child: CircularProgressIndicator()))
                : kRaisedButton(200, "Register", () {check();}),
              SizedBox(height: 10,),
            ],
          )
        ),
      ),
    );
  }

  void check() {
    if(title == null || subtitle == null) {
      Fluttertoast.showToast(msg: "Enter all details");
    } else if(title.length >= 25) {
      Fluttertoast.showToast(msg: "Maximum length of title is 25...");
    } else {
      setState(() {isLoading = true;});
      collectionReference.doc("Complaint").collection(date).doc().set({
        "complainttitle": title,
        "complaintsubtitle": subtitle,
        "complainee": name,
        "complaineeflat": flat,
      }).then((value) {
        setState(() {isLoading = false;});
        Fluttertoast.showToast(msg: "New Complaint Registered!");
        Navigator.popAndPushNamed(context, Complaints.id);
      });
    }
  }
}