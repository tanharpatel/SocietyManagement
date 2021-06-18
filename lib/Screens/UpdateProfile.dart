import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:societymanagement/Components/ConnectivityCheck.dart';
import 'package:societymanagement/Components/CustomAppBar.dart';
import 'package:societymanagement/Components/ProfileCard.dart';
import 'package:societymanagement/Components/RaisedBtn.dart';
import 'package:societymanagement/Components/TextField.dart';
import 'package:societymanagement/Screens/Dashboard.dart';
import 'package:societymanagement/Screens/Login.dart';
import 'package:societymanagement/Screens/Profile.dart';
import 'package:societymanagement/Utils/GetDetails.dart';
import 'package:societymanagement/Utils/GetSharedPref.dart';

class UpdateProfile extends StatefulWidget {
  static final String id = "UpdateProfile";
  @override
  _UpdateProfileState createState() => _UpdateProfileState();
}

class _UpdateProfileState extends State<UpdateProfile> {
  FocusNode nameFN, flatFN;
  String nameup, flatup;
  bool isLoading = false;

  @override
  void initState() {
    nameFN = FocusNode();
    flatFN = FocusNode();
    initial();
    super.initState();
  }

  @override
  void dispose() {
    nameFN.dispose();
    flatFN.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(56),
          child: appBar(context, "Update Profile"),
        ),
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              CircleAvatar(
                radius: 50,
                backgroundColor: Colors.white,
                child: Image.asset("assets/logo.png"),
              ),
              Text(
                society,
                style: TextStyle(
                  fontSize: 30,
                  color: Colors.blueAccent[700],
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Pacifico',
                ),
              ),
              editProfileCard(context, name, Icons.account_circle, nameFN, flatFN, TextInputType.name, (value){nameup = value;}, null),
              editProfileCard(context, flat, Icons.home, flatFN, null, TextInputType.text, (value){flatup = value;}, TextInputAction.done),
              profileCard(phone, Icons.phone_android),
              SizedBox(height: 20,),
              kRaisedButton(MediaQuery.of(context).size.width*0.75, "Update Profile", () {check();}),
              SizedBox(height: 20,),
            ],
          ),
        ),
      ),
    );
  }

  void check() {
    setState(() {isLoading = true;});
    collectionReference = FirebaseFirestore.instance.collection(soccode);
    collectionReference.doc(phone).update({
      "name": nameup ?? name,
      "flatno": flatup ?? flat,
    }).then((value) {
      Navigator.popAndPushNamed(context, Dashboard.id);
    });
  }
}