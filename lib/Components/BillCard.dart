import 'package:flutter/material.dart';
import 'package:societymanagement/Components/CustomPainter.dart';

class BillCard extends StatelessWidget {
  final String amount, category;
  final List<IconData> icons = [Icons.arrow_drop_down, Icons.lightbulb, Icons.water_damage, Icons.security, Icons.miscellaneous_services, Icons.event, Icons.festival];
  IconData icon;
  var colorS, colorE;
  BillCard({@required this.amount, @required this.category});
   var colors = [
    CategoryColor(Color(0xff6DC8F3), Color(0xff73A1F9)),
    CategoryColor(Color(0xffFFB157), Color(0xffFFA057)),
    CategoryColor(Color(0xffFF5B95), Color(0xffF8556D)),
    CategoryColor(Color(0xffD76EF5), Color(0xff8F7AFE)),
    CategoryColor(Color(0xffABEBC6), Color(0xff28B463)),
    CategoryColor(Color(0xff95A5A6), Color(0xff515A5A)),
  ];

  @override
  Widget build(BuildContext context) {
    if(category == "Select") {icon = icons[0];}
    else if(category == "Electricity") {icon = icons[1]; colorS = colors[1].startColor; colorE = colors[1].endColor;}
    else if(category == "Water") {icon = icons[2]; colorS = colors[0].startColor; colorE = colors[0].endColor;}
    else if(category == "Security") {icon = icons[3]; colorS = colors[5].startColor; colorE = colors[5].endColor;}
    else if(category == "Maintenance") {icon = icons[4]; colorS = colors[3].startColor; colorE = colors[3].endColor;}
    else if(category == "Events") {icon = icons[5]; colorS = colors[2].startColor; colorE = colors[2].endColor;}
    else if(category == "Festivals") {icon = icons[6]; colorS = colors[4].startColor; colorE = colors[4].endColor;}
  //   return Card(
  //   elevation: 10,
  //   shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
  //   child: ExpansionTile(
  //     title: Text(category, style: TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.w700,),),
  //     trailing: Icon(Icons.arrow_drop_down, color: Colors.blueAccent[700], size: 50,),
  //     children: [
  //       Divider(color: Colors.black, height: 3,),
  //       Padding(
  //         padding: const EdgeInsets.symmetric(horizontal: 10),
  //         child: Text(amount, softWrap: true, style: TextStyle(color: Colors.black, fontSize: 20,), textAlign: TextAlign.center,),
  //       ),
  //     ],
  //   ),
  // );
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Stack(
          children: <Widget>[
            Container(
              height: 100,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(24),
                gradient: LinearGradient(colors: [
                  colorS, colorE
                ], begin: Alignment.topLeft, end: Alignment.bottomRight),
                boxShadow: [
                  BoxShadow(
                    color: Color(0xff73A1F9),
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
                painter: CustomCardShapePainter(24, colorS, colorE),
              ),
            ),
            Positioned.fill(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Expanded(flex: 1, child: Icon(icon)),
                  Expanded(
                    flex: 3,
                    child: ListTile(
                      title: Text(category, style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.w700,), textAlign: TextAlign.center,),
                      subtitle: Text(amount, style: TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.w500,), textAlign: TextAlign.center,),
                    ),
                  ),
                  Expanded(flex: 1, child: SizedBox(width: 3,)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CategoryColor {
  final Color startColor;
  final Color endColor;

  CategoryColor(this.startColor, this.endColor);
}