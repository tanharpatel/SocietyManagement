import 'dart:async';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:societymanagement/Screens/AddBill.dart';
import 'package:societymanagement/Screens/AddComplaint.dart';
import 'package:societymanagement/Screens/Complaints.dart';
import 'package:societymanagement/Screens/AddNotice.dart';
import 'package:societymanagement/Screens/Contacts.dart';
import 'package:societymanagement/Screens/Dashboard.dart';
import 'package:societymanagement/Screens/UpdateProfile.dart';
import 'package:societymanagement/Screens/Login.dart';
import 'package:societymanagement/Screens/Notice.dart';
import 'package:societymanagement/Screens/Bills.dart';
import 'package:societymanagement/Screens/Payment.dart';
import 'package:societymanagement/Screens/Profile.dart';
import 'package:societymanagement/Screens/SignUp.dart';
import 'package:societymanagement/Screens/SocietyReg.dart';
import 'package:societymanagement/Screens/Summary.dart';
import 'package:societymanagement/Utils/GetSharedPref.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => SplashScreen(),
        Login.id: (context) => Login(),
        SignUp.id: (context) => SignUp(),
        SocietyReg.id: (context) => SocietyReg(),
        Dashboard.id: (context) => Dashboard(),
        Contacts.id: (context) => Contacts(),
        Payment.id: (context) => Payment(),
        Profile.id: (context) => Profile(),
        UpdateProfile.id: (context) => UpdateProfile(),
        Bills.id: (context) => Bills(),
        Notice.id: (context) => Notice(),
        Complaints.id: (context) => Complaints(),
        Summary.id: (context) => Summary(),
        AddBill.id: (context) => AddBill(),
        AddNotice.id: (context) => AddNotice(),
        AddComplaint.id: (context) => AddComplaint(),
      }
    );
  }
}

class SplashScreen extends StatefulWidget {
  static final String id = "SplashScreen";
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    initial();
    Timer(Duration(seconds: 4), () => checkIfAlreadyLoggedin());
    super.initState();
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Image.asset("assets/logo.png", height: 200,),
          SizedBox(height: 30,),
          Center(child: Text("Hello, Society!!", style: TextStyle(color: Colors.blueAccent[700], fontSize: 50, fontWeight: FontWeight.bold, fontFamily: "Allura"),)),
          SizedBox(height: 3,),
          Text("A Complete Apartment Management Solution", style: TextStyle(color: Colors.blueAccent[700], fontSize: 15, fontWeight: FontWeight.bold), textAlign: TextAlign.center,),
          SizedBox(height: 50,),
          SpinKitRipple(color: Colors.blueAccent[700], size: 60),
        ],
      ),
    );
  }

  void checkIfAlreadyLoggedin() {
    if(sharedpref.getString('soccode') != null && sharedpref.getString('phone') != null) {
      Navigator.pushReplacementNamed(context, Dashboard.id);
    } else {
      Navigator.pushReplacementNamed(context, Login.id);
    }
  }
}