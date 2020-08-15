import 'package:flutter/material.dart';
import 'package:societymanagement/Components/CustomWidgets.dart';

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
                onTap: () {FocusScope.of(context).requestFocus(phoneFN);},
                child: kTextField("Society Name", Icon(Icons.home), societyFN, society),
              ),
              SizedBox(height: 20,),
              GestureDetector(
                onTap: () {FocusScope.of(context).requestFocus(phoneFN);},
                child: kTextField("Secretary Name", Icon(Icons.person), secrataryFN, secratary),
              ),
              SizedBox(height: 20,),
              GestureDetector(
                onTap: () {FocusScope.of(context).requestFocus(phoneFN);},
                child: kTextField("Phone Number", Icon(Icons.phone_android), phoneFN, phone),
              ),
              SizedBox(height: 20,),
              GestureDetector(
                onTap: () {FocusScope.of(context).requestFocus(phoneFN);},
                child: kTextField("OTP", Icon(Icons.vpn_key), otpFN, otp),
              ),
              SizedBox(height: 20,),
              GestureDetector(
                onTap: () {FocusScope.of(context).requestFocus(phoneFN);},
                child: kTextField("E-Mail ID", Icon(Icons.email), emailFN, email),
              ),
              SizedBox(height: 20,),
              GestureDetector(
                onTap: () {FocusScope.of(context).requestFocus(phoneFN);},
                child: kTextField("Address", Icon(Icons.location_on), addressFN, address),
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