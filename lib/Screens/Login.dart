import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:societymanagement/Components/ConnectivityCheck.dart';
import 'package:societymanagement/Components/RaisedBtn.dart';
import 'package:societymanagement/Components/TextField.dart';
import 'package:societymanagement/Screens/Dashboard.dart';
import 'package:societymanagement/Screens/SignUp.dart';
import 'package:societymanagement/Screens/SocietyReg.dart';
import 'package:societymanagement/Utils/GetDetails.dart';
import 'package:societymanagement/Utils/GetSharedPref.dart';

class Login extends StatefulWidget {
  static final String id = "Login";
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  FocusNode soccodeFN, phoneFN, passwordFN;
  String soccode, phone, password;
  bool isLoading = false;

  @override
  void initState() {
    soccodeFN = FocusNode();
    phoneFN = FocusNode();
    passwordFN = FocusNode();
    initial();
    super.initState();
  }

  @override
  void dispose() {
    soccodeFN.dispose();
    phoneFN.dispose();
    passwordFN.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: ConnectivityCheck(
          childView: Padding(
            padding: const EdgeInsets.only(left: 10, right: 10),
            child: ListView(
              children: <Widget>[
                Image.asset("assets/logo.png", height: 150),
                SizedBox(height: 10,),
                Center(child: Text("Welcome back!", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 30),)),
                SizedBox(height: 25,),
                kTextField(context, "Society Code", Icon(Icons.vpn_key), soccodeFN, phoneFN, TextInputType.number, (value){soccode = value;}, null),
                SizedBox(height: 25,),
                kTextField(context, "Phone Number", Icon(Icons.phone_android), phoneFN, passwordFN, TextInputType.phone, (value){phone = value;}, null),
                SizedBox(height: 20,),
                kTextField(context, "Password", Icon(Icons.lock), passwordFN, null, TextInputType.text, (value){password = value;}, TextInputAction.done),
                SizedBox(height: 25,),
                isLoading 
                  ? Center(child: SizedBox(width: MediaQuery.of(context).size.width*0.1, child: CircularProgressIndicator()))
                  : kRaisedButton(150, "LOG IN", () {check();}),
                SizedBox(height: 30,),
                Center(child: Text("Society not registered??", style: TextStyle(color: Colors.grey),)),
                SizedBox(height: 5,),
                kRaisedButton(250, "Register Society", () {Navigator.pushNamed(context, SocietyReg.id);}),
                SizedBox(height: 30,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text("Don't have an account? ", style: TextStyle(color: Colors.black87,),),
                    GestureDetector(
                      onTap: () {Navigator.pushNamed(context, SignUp.id);},
                      child: Text("Sign Up", style: TextStyle(color: Colors.blueAccent[700], fontWeight: FontWeight.w600),),
                    ),
                  ],
                ),
                SizedBox(height: 10,),
              ],
            ),
          ),
        ),
      ),
    );
  }
  
  void check() {
    if(phone == null || password == null || soccode == null) {
      Fluttertoast.showToast(msg: "Enter all details");
    } else if(phone.length != 10) {
      Fluttertoast.showToast(msg: "Enter valid phone number");
    } else {
      setState(() {isLoading = true;});
      collectionReference = FirebaseFirestore.instance.collection(soccode);
      collectionReference.doc(phone).get().then((value) {
        if(password != value.data()["password"]) {
          setState(() {isLoading = false;});
          Fluttertoast.showToast(msg: "Incorrect Password");
        } else {
          sharedpref.setString('soccode', soccode);
          sharedpref.setString('phone', phone);
          Navigator.popAndPushNamed(context, Dashboard.id);
        }
      });
    }
  }
}