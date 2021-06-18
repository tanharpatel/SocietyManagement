// import 'package:flutter/material.dart';

// Widget complaintCard(String title, String subtitle, String complainee, String complaineeflat) {
//   return Card(
//     elevation: 10,
//     shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
//     child: ExpansionTile(
//       title: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text(title, style: TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.w700,),),
//           Text("By $complainee living in $complaineeflat", style: TextStyle(color: Colors.black, fontSize: 15, fontWeight: FontWeight.w500,),),
//         ],
//       ),
//       trailing: Icon(Icons.arrow_drop_down, color: Colors.blueAccent[700], size: 50,),
//       children: [
//         Divider(color: Colors.black, height: 3,),
//         Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 10),
//           child: Text(subtitle, softWrap: true, style: TextStyle(color: Colors.black, fontSize: 20,), textAlign: TextAlign.center,),
//         ),
//       ],
//     ),
//   );
// }

// class ComplaintCard extends StatelessWidget {
//   final String title, subtitle, complainee, complaineeflat;
//   ComplaintCard({@required this.title, @required this.subtitle, @required this.complainee, @required this.complaineeflat});

//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       elevation: 10,
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
//       child: ExpansionTile(
//         title: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(title, style: TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.w700,),),
//             Text("By $complainee living in $complaineeflat", style: TextStyle(color: Colors.black, fontSize: 15, fontWeight: FontWeight.w500,),),
//           ],
//         ),
//         trailing: Icon(Icons.arrow_drop_down, color: Colors.blueAccent[700], size: 50,),
//         children: [
//           Divider(color: Colors.black, height: 3,),
//           Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 10),
//             child: Text(subtitle, softWrap: true, style: TextStyle(color: Colors.black, fontSize: 20,), textAlign: TextAlign.center,),
//           ),
//         ],
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:societymanagement/Components/CustomPainter.dart';

class ComplaintCard extends StatefulWidget {
  final String title, subtitle, complainee, complaineeflat;
  ComplaintCard({@required this.title, @required this.subtitle, @required this.complainee, @required this.complaineeflat});

  @override
  _ComplaintCardState createState() => _ComplaintCardState();
}

class _ComplaintCardState extends State<ComplaintCard> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Stack(
          children: <Widget>[
            Container(
              height: 200,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(24),
                gradient: LinearGradient(colors: [
                  Color(0xff6DC8F3), Color(0xff73A1F9)
                ], begin: Alignment.topLeft, end: Alignment.bottomRight),
                boxShadow: [
                  BoxShadow(
                    color:  Color(0xff73A1F9),
                    blurRadius: 12,
                    offset: Offset(0, 6),
                  ),
                ],
              ),
            ),
            Positioned(
              right: 0,
              bottom: 0,
              top: 0,
              child: CustomPaint(
                size: Size(100, 150),
                painter: CustomCardShapePainter(24, Color(0xff6DC8F3), Color(0xff73A1F9)),
              ),
            ),
            Positioned.fill(
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Image.asset(
                      'assets/logo.png',
                      height: 64,
                      width: 64,
                    ),
                    flex: 2,
                  ),
                  Expanded(
                    flex: 5,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          widget.complainee,
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 25,
                              fontFamily: 'Roboto',
                              fontWeight: FontWeight.w700),
                        ),
                        SizedBox(height: 10,),
                        Text(
                          "Subject: ${widget.title}",
                          style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'Roboto',
                            fontSize: 15
                          ),
                        ),
                        SizedBox(height: 10),
                        Text(
                          "Description: ${widget.subtitle}",
                          style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'Roboto',
                            fontSize: 15
                          ),
                        ),
                        SizedBox(height:10),
                        Text(
                          "Flat No:  ${widget.complaineeflat}",
                          style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'Roboto',
                            fontSize: 15
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}