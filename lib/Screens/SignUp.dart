import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:societymanagement/Components/ConnectivityCheck.dart';
import 'package:societymanagement/Components/RaisedBtn.dart';
import 'package:societymanagement/Components/TextField.dart';
import 'package:societymanagement/Screens/Dashboard.dart';
import 'package:societymanagement/Screens/Login.dart';
import 'package:societymanagement/Services/auth.dart';
import 'package:societymanagement/Utils/GetDetails.dart';
import 'package:societymanagement/Utils/GetSharedPref.dart';

class SignUp extends StatefulWidget {
  static final String id = "Sign Up";
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  FocusNode nameFN, phoneFN, otpFN, flatFN, soccodeFN, passwordFN;
  String name, phone, otp, flat, soccode, password, verificationID;
  bool codeSent = false, isLoading = false;

  @override
  void initState() {
    nameFN = FocusNode();
    phoneFN = FocusNode();
    otpFN = FocusNode();
    flatFN = FocusNode();
    soccodeFN = FocusNode();
    passwordFN = FocusNode();
    initial();
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
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: ConnectivityCheck(
          childView: Padding(
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
                SizedBox(height: 30,),
                kTextField(context, "Full Name", Icon(Icons.person), nameFN, phoneFN, TextInputType.name, (value){name = value;}, null),
                SizedBox(height: 20,),
                kTextField(context, "Phone Number", Icon(Icons.phone_android), phoneFN, flatFN, TextInputType.phone, (value){phone = value;}, null),
                SizedBox(height: 20,),
                kTextField(context, "Flat Number", Icon(Icons.home), flatFN, passwordFN, TextInputType.text, (value){flat = value;}, null),
                SizedBox(height: 20,),
                kTextField(context, "Password", Icon(Icons.lock), passwordFN, soccodeFN, TextInputType.text, (value){password = value;}, null),
                SizedBox(height: 20,),
                kTextField(context, "Society Code", Icon(Icons.vpn_key), soccodeFN, otpFN, TextInputType.number, (value){soccode = value;}, null),
                SizedBox(height: 20,),
                codeSent ? kTextField(context, "OTP", Icon(Icons.vpn_key), otpFN, null, TextInputType.number, (value){otp = value;}, TextInputAction.done) : Container(),
                SizedBox(height: 25,),
                isLoading
                ? Center(child: SizedBox(width: MediaQuery.of(context).size.width*0.1, child: CircularProgressIndicator()))
                : kRaisedButton(150, codeSent ? "CREATE" : "Get OTP", () {check();}),
                SizedBox(height: 30,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text("Already have an account? ", style: TextStyle(color: Colors.black87,),),
                    GestureDetector(
                      onTap: () {Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => Login()));},
                      child: Text("Login here", style: TextStyle(color: Colors.blueAccent[700], fontWeight: FontWeight.w600),),
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
    if(name == null || phone == null || password == null || flat == null || soccode == null) {
      Fluttertoast.showToast(msg: "Enter all details");
    } else if(phone.length != 10) {
      Fluttertoast.showToast(msg: "Enter valid phone number");
    } else {
      setState(() {isLoading = true;});
      !codeSent
        ? verify(phone)
        : collectionReference = FirebaseFirestore.instance.collection(soccode);
          collectionReference.doc(phone).set({
            "name": name,
            "flatno": flat,
            "password": password
          }).then((value) {
            sharedpref.setString('soccode', soccode);
            sharedpref.setString('phone', phone);
            Navigator.popAndPushNamed(context, Dashboard.id);
          });
    }
  }

  Future<void> verify(phone) async {
    final PhoneVerificationCompleted verified = (AuthCredential authResult) {
      Auth().signIn(otp, verificationID, context);
    };

    final PhoneVerificationFailed failed = (FirebaseAuthException authFailed) {
      setState(() {isLoading = false;});
      Fluttertoast.showToast(msg: "${authFailed.message}");
    };

    final PhoneCodeSent smsSent = (String verID, [int forceResend]) {
      setState(() {isLoading = false;});
      Fluttertoast.showToast(msg: "Code Sent");
      setState(() {
        verificationID = verID;
        codeSent = true;
      });
    };

    final PhoneCodeAutoRetrievalTimeout autoTimeout = (String verID) {
      verificationID = verID;
    };

    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: "+91$phone",
      verificationCompleted: verified,
      verificationFailed: failed,
      codeSent: smsSent,
      timeout: Duration(seconds: 5),
      codeAutoRetrievalTimeout: autoTimeout,
    );
  }
}