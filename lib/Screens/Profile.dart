import 'package:flutter/material.dart';
import 'package:societymanagement/Components/CustomAppBar.dart';
import 'package:societymanagement/Components/ProfileCard.dart';
import 'package:societymanagement/Components/RaisedBtn.dart';
import 'package:societymanagement/Screens/UpdateProfile.dart';
import 'package:societymanagement/Utils/GetDetails.dart';

class Profile extends StatefulWidget {
  static final String id = "Profile";
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(56),
          child: appBar(context, "Profile"),
        ),
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
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
                  fontFamily: 'Bitter',
                ),
              ),
              profileCard(name, Icons.account_circle),
              profileCard(phone, Icons.phone_android),
              profileCard(flat, Icons.home),
              profileCard("Secratary: $secretary", Icons.person),
              profileCard("Secratary: $phoneno", Icons.phone_android),
              profileCard("Society Code: $soccode", Icons.vpn_key),
              SizedBox(height: 20,),
              kRaisedButton(
                MediaQuery.of(context).size.width*0.75, "Edit Profile",
                () {Navigator.pushNamed(context, UpdateProfile.id);}
              ),
              SizedBox(height: 20,),
            ],
          ),
        ),
      ),
    );
  }
}