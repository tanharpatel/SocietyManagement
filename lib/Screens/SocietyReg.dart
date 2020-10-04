import 'package:flutter/material.dart';
import 'package:societymanagement/Components/RaisedBtn.dart';
import 'package:societymanagement/Components/TextField.dart';

class SocietyReg extends StatefulWidget {
  static final String id = "Society Register";

  @override
  _SocietyRegState createState() => _SocietyRegState();
}

class _SocietyRegState extends State<SocietyReg> {
  FocusNode societyFN, secrataryFN, phoneFN, otpFN, emailFN, addressFN;
  String society, secratary, phone, otp, email, address;

  @override
  void initState() {
    societyFN = FocusNode();
    secrataryFN = FocusNode();
    phoneFN = FocusNode();
    otpFN = FocusNode();
    emailFN = FocusNode();
    addressFN = FocusNode();
    super.initState();
  }

  @override
  void dispose() {
    societyFN.dispose();
    secrataryFN.dispose();
    phoneFN.dispose();
    otpFN.dispose();
    emailFN.dispose();
    addressFN.dispose();
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
                onTap: () {FocusScope.of(context).requestFocus(societyFN);},
                child: kTextField("Society Name", Icon(Icons.home), societyFN, TextInputType.text, (value){society = value;}),
              ),
              SizedBox(height: 20,),
              GestureDetector(
                onTap: () {FocusScope.of(context).requestFocus(secrataryFN);},
                child: kTextField("Secretary Name", Icon(Icons.person), secrataryFN, TextInputType.text, (value){secratary = value;}),
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
                onTap: () {FocusScope.of(context).requestFocus(emailFN);},
                child: kTextField("E-Mail ID", Icon(Icons.email), emailFN, TextInputType.emailAddress, (value){email = value;}),
              ),
              SizedBox(height: 20,),
              GestureDetector(
                onTap: () {FocusScope.of(context).requestFocus(addressFN);},
                child: kTextField("Address", Icon(Icons.location_on), addressFN, TextInputType.text, (value){address = value;}),
              ),
              SizedBox(height: 25,),
              kRaisedButton(200, "REGISTER", () {}),
              SizedBox(height: 30,),
            ],
          ),
        ),
      ),      
    );
  }
}