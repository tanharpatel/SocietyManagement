import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:societymanagement/Components/ConnectivityCheck.dart';
import 'package:societymanagement/Components/RaisedBtn.dart';
import 'package:societymanagement/Components/TextField.dart';
import 'package:societymanagement/Screens/Dashboard.dart';
import 'package:societymanagement/Services/auth.dart';
import 'package:societymanagement/Utils/GetDetails.dart';
import 'package:societymanagement/Utils/GetSharedPref.dart';

class SocietyReg extends StatefulWidget {
  static final String id = "Society Register";
  @override
  _SocietyRegState createState() => _SocietyRegState();
}

class _SocietyRegState extends State<SocietyReg> {
  FocusNode societyFN, secretaryFN, phoneFN, flatFN, passwordFN, soccodeFN, addressFN;
  String society, secretary, phone, flat, password, soccode, address, verificationID;
  bool codeSent = false, isLoading = false;

  @override
  void initState() {
    societyFN = FocusNode();
    secretaryFN = FocusNode();
    phoneFN = FocusNode();
    flatFN = FocusNode();
    passwordFN = FocusNode();
    soccodeFN = FocusNode();
    addressFN = FocusNode();
    initial();
    super.initState();
  }

  @override
  void dispose() {
    societyFN.dispose();
    secretaryFN.dispose();
    phoneFN.dispose();
    flatFN.dispose();
    passwordFN.dispose();
    soccodeFN.dispose();
    addressFN.dispose();
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
                kTextField(context, "Society Name", Icon(Icons.home), societyFN, addressFN, TextInputType.text, (value){society = value;}, null),
                SizedBox(height: 20,),
                kTextField(context, "Society Address", Icon(Icons.location_on), addressFN, secretaryFN, TextInputType.text, (value){address = value;}, TextInputAction.next),
                SizedBox(height: 20,),
                kTextField(context, "Secretary Name", Icon(Icons.person), secretaryFN, phoneFN, TextInputType.name, (value){secretary = value;}, null),
                SizedBox(height: 20,),
                kTextField(context, "Phone Number", Icon(Icons.phone_android), phoneFN, flatFN, TextInputType.phone, (value){phone = value;}, null),
                SizedBox(height: 20,),
                kTextField(context, "Flat Number", Icon(Icons.home), flatFN, passwordFN, TextInputType.text, (value){flat = value;}, null),
                SizedBox(height: 20,),
                kTextField(context, "Password", Icon(Icons.lock), passwordFN, soccodeFN, TextInputType.text, (value){password = value;}, null),
                SizedBox(height: 20,),
                codeSent ? kTextField(context, "Society Code", Icon(Icons.vpn_key), soccodeFN, null, TextInputType.number, (value){soccode = value;}, TextInputAction.done) : Container(),
                SizedBox(height: 25,),
                isLoading
                  ? Center(child: SizedBox(width: MediaQuery.of(context).size.width*0.1, child: CircularProgressIndicator()))
                  : kRaisedButton(200, codeSent ? "REGISTER" : "Get Society Code", () {check();}),
                SizedBox(height: 10,),
              ],
            ),
          ),
        ),      
      ),
    );
  }

  void check() {
    if(society == null || address == null || secretary == null || phone == null || flat == null || password == null) {
      Fluttertoast.showToast(msg: "Enter all details");
    } else if(phone.length != 10) {
      Fluttertoast.showToast(msg: "Enter valid phone number");
    } else {
      setState(() {isLoading = true;});
      !codeSent
        ? verify(phone)
        : collectionReference = FirebaseFirestore.instance.collection(soccode);
          collectionReference.doc("Admin").set({
            "society": society,
            "address": address,
            "secretary": secretary,
            "phone": phone,
            "soccode": soccode
          });
          collectionReference.doc(phone).set({
            "name": secretary,
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
      Auth().signIn(soccode, verificationID, context);
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