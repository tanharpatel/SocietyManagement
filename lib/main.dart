import 'dart:async';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:societymanagement/Screens/Dashboard.dart';
import 'package:societymanagement/Screens/Login.dart';
import 'package:societymanagement/Screens/SignUp.dart';
import 'package:societymanagement/Screens/SocietyReg.dart';
import 'package:societymanagement/Services/auth.dart';

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
    initialRoute: "/",
    routes: {
      '/': (context) => SplashScreen(),
      Login.id: (context) => Login(),
      SignUp.id: (context) => SignUp(),
      SocietyReg.id: (context) => SocietyReg(),
      Dashboard.id: (context) => Dashboard(),
    }
  );
  }
}

class SplashScreen extends StatefulWidget {
  static final String id = "Splash Screen";

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    Timer(Duration(seconds: 4), () {Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Login()));});
    // Timer(Duration(seconds: 4), () {Auth().handleAuth();});
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
          Center(child: Text("Hello, Society!!", style: TextStyle(color: Colors.blueAccent[700], fontSize: 25, fontWeight: FontWeight.bold),)),
          SizedBox(height: 3,),
          Text("A complete Apartment Management Solution", style: TextStyle(color: Colors.blueAccent[700], fontSize: 15, fontWeight: FontWeight.bold), textAlign: TextAlign.center,),
          SizedBox(height: 50,),
          SpinKitRipple(color: Colors.blueAccent[700], size: 60),
        ],
      ),
    );
  }
}