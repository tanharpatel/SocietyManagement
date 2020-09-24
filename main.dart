import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            child: Stack(
      children: <Widget>[
        content, //stack overlaps widgets
        Opacity(
          //semi red clippath with more height and with 0.5 opacity
          opacity: 0.5,
          child: ClipPath(
            clipper: WaveClipper(), //set our custom wave clipper
            child: Container(
              color: Colors.blue[400],
              height: 140,
            ),
          ),
        ),

        ClipPath(
          //upper clippath with less height
          clipper: WaveClipper(), //set our custom wave clipper.
          child: Container(
            padding: EdgeInsets.only(bottom: 50),
            color: Colors.blueAccent,
            height: 120,
            alignment: Alignment.center,
          ),
        ),
      ],
    )));
  }

  get content => Container(
        child: Column(
          children: <Widget>[grid],
        ),
      );

  get grid => Expanded(
        child: Container(
          padding: EdgeInsets.only(left: 26, top: 126, right: 26, bottom: 56),
          child: GridView.count(
            crossAxisCount: 3,
            childAspectRatio: .90,
            children: List.generate(6, (_) {
              return Card(
                elevation: 2,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8)),
                child: Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[FlutterLogo(), Text('Bill')],
                  ),
                ),
              );
            }),
          ),
        ),
      );
}

class WaveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = new Path();
    path.lineTo(
        0, size.height); //start path with this if you are making at bottom

    var firstStart = Offset(size.width / 5, size.height);
    //fist point of quadratic bezier curve
    var firstEnd = Offset(size.width / 2.25, size.height - 50.0);
    //second point of quadratic bezier curve
    path.quadraticBezierTo(
        firstStart.dx, firstStart.dy, firstEnd.dx, firstEnd.dy);

    var secondStart =
        Offset(size.width - (size.width / 3.24), size.height - 105);
    //third point of quadratic bezier curve
    var secondEnd = Offset(size.width, size.height - 10);
    //fourth point of quadratic bezier curve
    path.quadraticBezierTo(
        secondStart.dx, secondStart.dy, secondEnd.dx, secondEnd.dy);

    path.lineTo(
        size.width, 0); //end with this path if you are making wave at bottom
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false; //if new instance have different instance than old instance
    //then you must return true;
  }
}
