import 'package:flutter/material.dart';
import 'package:societymanagement/Components/RaisedBtn.dart';
import 'package:societymanagement/Components/TextField.dart';
import 'package:societymanagement/Screens/Login.dart';

class SignUp extends StatefulWidget {
  static final String id = "Sign Up";

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  FocusNode nameFN, phoneFN, otpFN, flatFN, soccodeFN;
  String name, phone, otp, flat, soccode;

  @override
  void initState() {
    nameFN = FocusNode();
    phoneFN = FocusNode();
    otpFN = FocusNode();
    flatFN = FocusNode();
    soccodeFN = FocusNode();
    super.initState();
  }

  @override
  void dispose() {
    nameFN.dispose();
    phoneFN.dispose();
    otpFN.dispose();
    flatFN.dispose();
    soccodeFN.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(left: 10, right: 10),
          child: ListView(
            children: <Widget>[
              SizedBox(height: 10,),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  IconButton(icon: Icon(Icons.arrow_back), onPressed: () {Navigator.pop(context);},),
                ],
              ),
              SizedBox(height: 10,),
              Center(child: Text("Let's Get Started!", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 30),)),
              SizedBox(height: 10,),
              Center(child: Text("Create an account at  ", style: TextStyle(color: Colors.grey),)),
              SizedBox(height: 60,),
              GestureDetector(
                onTap: () {FocusScope.of(context).requestFocus(nameFN);},
                child: kTextField("Full Name", Icon(Icons.person), nameFN, TextInputType.text, (value){name = value;}),
              ),
              SizedBox(height: 20,),
              GestureDetector(
                onTap: () {FocusScope.of(context).requestFocus(phoneFN);},
                child: kTextField("Phone Number", Icon(Icons.phone_android), phoneFN, TextInputType.phone, (value){phone = value;}),
              ),
              SizedBox(height: 20,),
              GestureDetector(
                onTap: () {FocusScope.of(context).requestFocus(otpFN);},
                child: kTextField("OTP", Icon(Icons.vpn_key), otpFN, TextInputType.number, (value){otp = value;}),
              ),
              SizedBox(height: 20,),
              GestureDetector(
                onTap: () {FocusScope.of(context).requestFocus(flatFN);},
                child: kTextField("Flat Number", Icon(Icons.home), flatFN, TextInputType.text, (value){flat = value;}),
              ),
              SizedBox(height: 20,),
              GestureDetector(
                onTap: () {FocusScope.of(context).requestFocus(soccodeFN);},
                child: kTextField("Society Code", Icon(Icons.lock), soccodeFN, TextInputType.number, (value){soccode = value;}),
              ),
              SizedBox(height: 25,),
              kRaisedButton(150, "CREATE", () {}),
              SizedBox(height: 30,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text("Already have an account? ", style: TextStyle(color: Colors.black87,),),
                  GestureDetector(
                    onTap: () {Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => Login()));},
                    child: Text("Login here", style: TextStyle(color: Colors.blue, fontWeight: FontWeight.w600),),
                  ),
                ],
              ),
              SizedBox(height: 20,),
            ],
          ),
        ),
      ),
    );
  }
}