import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:societymanagement/Components/ConnectivityCheck.dart';
import 'package:societymanagement/Components/DashbardCart.dart';
import 'package:societymanagement/Components/NoticeCard.dart';
import 'package:societymanagement/Screens/Complaints.dart';
import 'package:societymanagement/Screens/Contacts.dart';
import 'package:societymanagement/Screens/Login.dart';
import 'package:societymanagement/Screens/Notice.dart';
import 'package:societymanagement/Screens/Bills.dart';
import 'package:societymanagement/Screens/Payment.dart';
import 'package:societymanagement/Screens/Profile.dart';
import 'package:societymanagement/Screens/Summary.dart';
import 'package:societymanagement/Utils/GetDetails.dart';
import 'package:societymanagement/Utils/GetSharedPref.dart';

class Dashboard extends StatefulWidget {
  static final String id = "Dashboard";
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {

  @override
  void initState() {
    initial();
    super.initState();
  }
  
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.blueAccent[700],
          centerTitle: true,
          title: FutureBuilder(
            future: getData(),
            builder: (context,snapshot){
              if(snapshot.connectionState == ConnectionState.waiting){
                return Text(
                  "Hello!!!",
                  style: Theme.of(context).textTheme.headline6.merge(TextStyle(color: Colors.white)),
                );
              } else {
                return Text(
                  "Hello $flat!!!",
                  softWrap: true,
                  style: Theme.of(context).textTheme.headline6.merge(TextStyle(color: Colors.white)),
                );
              }
            }
          ),
          actions: [
            IconButton(
              icon: Icon(Icons.logout),
              onPressed: () {
                sharedpref.clear();
                Navigator.pushReplacementNamed(context, Login.id);
              }
            ),
          ],
        ),
        body: ConnectivityCheck(
          childView: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  dashboardCard(context, "Bills", "delesign-invoice", (){Navigator.pushNamed(context, Bills.id);}),
                  dashboardCard(context, "Summary", "delesign-financial-market-growth", (){Navigator.pushNamed(context, Summary.id);}),
                  dashboardCard(context, "Payments", "delesign-payment-processed", (){Navigator.pushNamed(context, Payment.id);}),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  dashboardCard(context, "Contacts", "flame-808", (){Navigator.pushNamed(context, Contacts.id);}),
                  dashboardCard(context, "Complaints", "delesign-bank", (){Navigator.pushNamed(context, Complaints.id);}),
                  dashboardCard(context, "Profile", "profile", (){Navigator.pushNamed(context, Profile.id);}),
                ],
              ),
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: Container(
                      width: MediaQuery.of(context).size.width*0.5,
                      decoration: BoxDecoration(
                        color: Colors.blueAccent[700],
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 5),
                        child: Center(child: Text("Notices", style: Theme.of(context).textTheme.headline6.merge(TextStyle(color: Colors.white, fontWeight: FontWeight.bold)))),
                      )
                    ),
                  ),
                  GestureDetector(
                    onTap: (){Navigator.pushNamed(context, Notice.id);},
                    child: Container(
                      // decoration: BoxDecoration(
                      //   borderRadius: BorderRadius.circular(20),
                      //   color: Colors.white,
                      //   boxShadow: [
                      //     BoxShadow(
                      //       color: Colors.black26,
                      //       blurRadius: 5,
                      //       spreadRadius: 0.7,
                      //       offset: Offset(-2, 2),
                      //     ),
                      //   ]
                      // ),
                      height: MediaQuery.of(context).size.height*0.30,
                      width: MediaQuery.of(context).size.width,
                      // child: FutureBuilder(
                      //   future: getData(),
                      //   builder: (context, snapshot) {
                      //     if(snapshot.connectionState == ConnectionState.waiting) {
                      //       return Center(child: CircularProgressIndicator(),);
                      //     } else {
                      //       return Column(
                      //         mainAxisAlignment: MainAxisAlignment.center,
                      //         crossAxisAlignment: CrossAxisAlignment.center,
                      //         children: [
                      //           Container(
                      //             child: Padding(
                      //               padding: const EdgeInsets.all(8.0),
                      //               child: Text(
                      //                 title[0].toString() ?? 'No Notice Yet!!!',
                      //                 style: Theme.of(context).textTheme.headline5.merge(
                      //                   TextStyle(
                      //                     fontFamily: 'Lora',
                      //                     fontWeight: FontWeight.bold,
                      //                   ),
                      //                 ),
                      //               ),
                      //             ),
                      //           ),
                      //           Padding(
                      //             padding: const EdgeInsets.all(8.0),
                      //             child: Text(
                      //               subtitle[0].toString() ?? '',
                      //               softWrap: true,
                      //               maxLines: 3,
                      //               overflow: TextOverflow.ellipsis,
                      //               style: Theme.of(context).textTheme.headline6.merge(
                      //                 TextStyle(
                      //                   fontFamily: 'Lora',
                      //                 ),
                      //               ),
                      //             ),
                      //           ),
                      //         ],
                      //       );
                      //     }
                      //   },
                      // ),
                      child: StreamBuilder<QuerySnapshot>(
                        stream: collectionReference.doc("Notice").collection(date).limit(1).snapshots(),
                        builder: (context, snapshot) {
                          if(snapshot.connectionState == ConnectionState.waiting) {
                            return CircularProgressIndicator();
                          } else {
                            if(snapshot.hasData) {
                              final notices = snapshot.data.docs;
                              List<DashboardNotice> noticesCards = [];
                              for (var notice in notices) {
                                final noticetitle = notice.data()['title'];
                                final noticesubtitle = notice.data()['subtitle'];
                                final noticesCard = DashboardNotice(title: noticetitle, subtitle: noticesubtitle,);
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
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}