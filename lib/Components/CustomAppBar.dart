import 'package:flutter/material.dart';
import 'package:societymanagement/Screens/Login.dart';
import 'package:societymanagement/Utils/GetSharedPref.dart';

Widget appBar(BuildContext context, String text) {
  return AppBar(
    title: Text(text),
    backgroundColor: Colors.blueAccent[700],
    actions: [
      IconButton(
        icon: Icon(Icons.logout),
        onPressed: () {
          sharedpref.clear();
          Navigator.pushReplacementNamed(context, Login.id);
        }
      ),
    ],
  );
}