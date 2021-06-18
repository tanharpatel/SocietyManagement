import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:societymanagement/Components/ComplaintCard.dart';
import 'package:societymanagement/Components/ConnectivityCheck.dart';
import 'package:societymanagement/Components/CustomAppBar.dart';
import 'package:societymanagement/Screens/AddComplaint.dart';
import 'package:societymanagement/Screens/Login.dart';
import 'package:societymanagement/Utils/GetDetails.dart';
import 'package:societymanagement/Utils/GetSharedPref.dart';

class Complaints extends StatefulWidget {
  static final String id = "Complaints";
  @override
  _ComplaintsState createState() => _ComplaintsState();
}

class _ComplaintsState extends State<Complaints> {
  String selecteddate;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Complaints"),
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
        //     future: getData(),
        //     builder: (context, snapshot) {
        //       if(snapshot.connectionState == ConnectionState.waiting) {
        //         return Center(child: CircularProgressIndicator(),);
        //       } else if(snapshot == null) {
        //         return Center(child: Text("No Complaints Registered Yet!!!"),);
        //       } else {
        //         return Padding(
        //           padding: const EdgeInsets.all(3),
        //           child: ListView.separated(
        //             separatorBuilder: (context, index) => SizedBox(height: 5,),
        //             itemCount: complainttitle.length,
        //             itemBuilder: (context, index) {
        //               return complaintCard(complainttitle[index], complaintsubtitle[index], complainee[index], complaineeflat[index]);
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
                stream: collectionReference.doc("Complaint").collection(selecteddate ?? date).snapshots(),
                builder: (context, snapshot) {
                  if(snapshot.connectionState == ConnectionState.waiting) {
                    return CircularProgressIndicator();
                  } else {
                    // print(snapshot.hasData);
                    // print(!snapshot.hasData);
                    if(snapshot.hasData) {
                      final complaints = snapshot.data.docs;
                      List<ComplaintCard> complaintsCards = [];
                      for (var complaint in complaints) {
                        final complainttitle = complaint.data()['complainttitle'];
                        final complaintsubtitle = complaint.data()['complaintsubtitle'];
                        final complainee = complaint.data()['complainee'];
                        final complaineeflat = complaint.data()['complaineeflat'];
                        final complaintsCard = ComplaintCard(title: complainttitle, subtitle: complaintsubtitle, complainee: complainee, complaineeflat: complaineeflat,);
                        complaintsCards.add(complaintsCard);
                      }
                      return Expanded(child: ListView(children: complaintsCards,));
                    } else if(!snapshot.hasData) {
                      return Center(child: Text("No Complaints Registered Yet!!!"),);
                    }
                  }
                }
              ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.blueAccent[700],
          child: Icon(Icons.add),
          onPressed: (){Navigator.popAndPushNamed(context, AddComplaint.id);},
        ),
      ),
    );
  }
}