import 'package:flutter/material.dart';
import 'package:societymanagement/Components/CustomWidgets.dart';
import 'package:societymanagement/Screens/SignUp.dart';
import 'package:societymanagement/Screens/SocietyReg.dart';

class Login extends StatefulWidget {
  static final String id = "Login";

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  FocusNode phoneFN, otpFN;
  String phone, otp;

  @override
  void initState() {
    phoneFN = FocusNode();
    otpFN = FocusNode();
    super.initState();
  }

  @override
  void dispose() {
    phoneFN.dispose();
    otpFN.dispose();
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
              SizedBox(height: 20,),
              Image.asset("assets/logo.png", height: 200),
              SizedBox(height: 10,),
              Center(child: Text("Welcome back!", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 30),)),
              SizedBox(height: 10,),
              Center(child: Text("Log in to your existant account of ", style: TextStyle(color: Colors.grey),)),
              SizedBox(height: 60,),
              GestureDetector(
                onTap: () {FocusScope.of(context).requestFocus(phoneFN);},
                child: kTextField("Phone Number", Icon(Icons.phone_android), phoneFN, phone),
              ),
              SizedBox(height: 20,),
              GestureDetector(
                onTap: () {FocusScope.of(context).requestFocus(otpFN);},
                child: kTextField("OTP", Icon(Icons.vpn_key), otpFN, otp),
              ),
              SizedBox(height: 25,),
              kRaisedButton(150, "LOG IN", () {}),
              SizedBox(height: 40,),
              Center(child: Text("Society not registered??", style: TextStyle(color: Colors.grey),)),
              SizedBox(height: 5,),
              kRaisedButton(250, "Register Society", () {Navigator.of(context).push(MaterialPageRoute(builder: (context) => SocietyReg()));}),
              SizedBox(height: 30,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text("Don't have an account? ", style: TextStyle(color: Colors.black87,),),
                  GestureDetector(
                    onTap: () {Navigator.push(context, MaterialPageRoute(builder: (context) => SignUp()));},
                    child: Text("Sign Up", style: TextStyle(color: Colors.blue, fontWeight: FontWeight.w600),),
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