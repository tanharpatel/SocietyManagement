import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:societymanagement/Components/ConnectivityCheck.dart';
import 'package:societymanagement/Components/CustomAppBar.dart';
import 'package:societymanagement/Components/NoticeCard.dart';
import 'package:societymanagement/Screens/AddNotice.dart';
import 'package:societymanagement/Screens/Login.dart';
import 'package:societymanagement/Utils/GetDetails.dart';
import 'package:societymanagement/Utils/GetSharedPref.dart';

class Notice extends StatefulWidget {
  static final String id = "Notice";
  @override
  _NoticeState createState() => _NoticeState();
}

class _NoticeState extends State<Notice> {
  String selecteddate;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Notice"),
          backgroundColor: Colors.blueAccent[700],
          actions: [
            IconButton(
              icon: Icon(Icons.calendar_today),
              onPressed: () async {
                final now = await showDatePicker(
                  context: context,
                  firstDate: DateTime(1960),
                  initialDate: DateTime.now(),
                  lastDate: DateTime(2100));
                if(date != null) {
                  var formatter = new DateFormat('yyyy-MM-dd');
                  setState(() {
                    selecteddate = formatter.format(now);
                  });
                }
              }
            ),
            IconButton(
              icon: Icon(Icons.logout),
              onPressed: () {
                sharedpref.clear();
                Navigator.pushReplacementNamed(context, Login.id);
              }
            ),
          ],
        ),
        // body: ConnectivityCheck(
        //   childView: FutureBuilder(
        //     future: getNotice(selecteddate),
        //     builder: (context, snapshot) {
        //       if(snapshot.connectionState == ConnectionState.waiting) {
        //         return Center(child: CircularProgressIndicator(),);
        //       } else if(snapshot == null) {
        //         return Center(child: Text("No Notices Yet!!!"),);
        //       } else {
        //         return Padding(
        //           padding: const EdgeInsets.all(3),
        //           child: ListView.separated(
        //             separatorBuilder: (context, index) => SizedBox(height: 5,),
        //             itemCount: title.length,
        //             itemBuilder: (context, index) {
        //               return noticeCard(title[index], subtitle[index]);
        //             },
        //           ),
        //         );
        //       }
        //     },
        //   ),
        // ),
        body: ConnectivityCheck(
          childView: Column(
            children: [
              StreamBuilder<QuerySnapshot>(
                stream: collectionReference.doc("Notice").collection(selecteddate ?? date).snapshots(),
                builder: (context, snapshot) {
                  if(snapshot.connectionState == ConnectionState.waiting) {
                    return CircularProgressIndicator();
                  } else {
                    if(snapshot.hasData) {
                      final notices = snapshot.data.docs;
                      List<NoticeCard> noticesCards = [];
                      for (var notice in notices) {
                        final noticetitle = notice.data()['title'];
                        final noticesubtitle = notice.data()['subtitle'];
                        final noticesCard = NoticeCard(title: noticetitle, subtitle: noticesubtitle,);
                        noticesCards.add(noticesCard);
                      }
                      return Expanded(child: ListView(children: noticesCards,));
                    } else if(!snapshot.hasData) {
                      return Center(child: Text("No Notices Yet!!!"),);
                    }
                    return Container();
                  }
                }
              ),
            ],
          ),
        ),
        floatingActionButton: Visibility(
          visible: isAdmin,
          child: FloatingActionButton(
            backgroundColor: Colors.blueAccent[700],
            child: Icon(Icons.add),
            onPressed: (){Navigator.popAndPushNamed(context, AddNotice.id);},
          ),
        ),
      ),
    );
  }

  // getNotice(String selecteddate) async {
  //   final noticesList = await collectionReference.doc("Notice").collection(selecteddate).get();
  //   for(var notices in noticesList.docs) {
  //     print(notices);
  //   }
  // }

  // noticeStream(String selecteddate) async {
  //   await for(var snapshot in collectionReference.doc("Notice").collection(selecteddate).snapshots()) {
  //     for(var notices in snapshot.docs) {
  //       print(notices);
  //     }
  //   }
  // }
}