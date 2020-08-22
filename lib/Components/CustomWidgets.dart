import 'package:flutter/material.dart';

Widget kTextField (String labelText, Icon prefixIcon, FocusNode focusNode, String textField) {
  return Material(
    elevation: 3,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
    child: TextField(
      focusNode: focusNode,
      onChanged: (value) {textField = value;},
      cursorColor: Colors.blue,
      keyboardType: TextInputType.number,
      style: TextStyle(color: Colors.blue),
      decoration: InputDecoration(
        focusColor: Colors.blue,
        labelText: labelText,
        labelStyle: TextStyle(color: focusNode.hasFocus ? Colors.blue : Colors.grey),
        prefixIcon: prefixIcon,
        prefixStyle: TextStyle(color: Colors.blue),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
          borderRadius: BorderRadius.circular(30),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.blue, width: 2),
          borderRadius: BorderRadius.circular(30),
        ),
        // errorText: "OTP can't be empty",
        // errorStyle: TextStyle(color: Colors.red),
        // errorBorder: OutlineInputBorder(
        //   borderSide: BorderSide(color: Colors.red),
        //   borderRadius: BorderRadius.circular(30),
        // ),
      ),
    ),
  );
}

Widget kRaisedButton (double width, String text, Function onPressed) {
  return Center(
    child: SizedBox(
      width: width,
      child: RaisedButton(
        focusElevation: 3,
        onPressed: onPressed,
        child: Text(text, style: TextStyle(color: Colors.white,),),
        elevation: 3,
        color: Colors.blueAccent[700],
        disabledColor: Colors.transparent,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30),),
      ),
    ),
  );
}