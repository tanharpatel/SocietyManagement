import 'package:flutter/material.dart';

Widget kTextField (String labelText, Icon prefixIcon, FocusNode focusNode, TextInputType keyboard, Function onChanged) {
  return Material(
    elevation: 3,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
    child: TextField(
      focusNode: focusNode,
      onChanged: onChanged,
      cursorColor: Colors.blue,
      keyboardType: keyboard,
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
      ),
    ),
  );
}