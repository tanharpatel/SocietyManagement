import 'package:flutter/material.dart';

void main() => runApp(
  MaterialApp(
    debugShowCheckedModeBanner: false,
    initialRoute: "/",
    routes: {
      '/': (context) => SplashScreen(),
    }
  )
);

class SplashScreen extends StatelessWidget {
  static final String id = "Splash Screen";

  @override
  Widget build(BuildContext context) {
    return Container(
      
    );
  }
}