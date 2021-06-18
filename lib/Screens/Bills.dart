import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:societymanagement/Components/BillCard.dart';
import 'package:societymanagement/Components/ConnectivityCheck.dart';
import 'package:societymanagement/Components/CustomAppBar.dart';
import 'package:societymanagement/Screens/AddBill.dart';
import 'package:societymanagement/Screens/Login.dart';
import 'package:societymanagement/Utils/GetDetails.dart';
import 'package:societymanagement/Utils/GetSharedPref.dart';

class Bills extends StatefulWidget {
  static final String id = "Bills";
  @override
  _BillsState createState() => _BillsState();
}

class _BillsState extends State<Bills> {
  String selecteddate;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Bills"),
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
        //   childView: ListView.separated(
        //     separatorBuilder: (context, index) => SizedBox(height: 5,),
        //     itemCount: 1,
        //     itemBuilder: (context, index) {
        //       return ListTile(
        //         title: Text("title"),
        //         subtitle: Text("subtitle")
        //       );
        //     },
        //   ),
        // ),
        body: ConnectivityCheck(
          childView: Column(
            children: [
              StreamBuilder<QuerySnapshot>(
                stream: collectionReference.doc("Bill").collection(selecteddate ?? date).snapshots(),
                builder: (context, snapshot) {
                  if(snapshot.connectionState == ConnectionState.waiting) {
                    return CircularProgressIndicator();
                  } else {
                    if(snapshot.hasData) {
                      final bills = snapshot.data.docs;
                      List<BillCard> billsCards = [];
                      for (var bill in bills) {
                        final id = bill.id;
                        final category = bill.data()['category'];
                        final amount = bill.data()['amount'];
                        final billsCard = BillCard(category: category, amount: amount,);
                        if(id != "Electricity" && id != "Events" && id != "Festivals" && id != "Security" && id != "Water" && id != "Maintenance") {
                          billsCards.add(billsCard);
                        } else {}
                      }
                      return Expanded(child: ListView(children: billsCards,));
                    } else if(!snapshot.hasData) {
                      return Center(child: Text("No Bills Yet!!!"),);
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
          onPressed: (){Navigator.popAndPushNamed(context, AddBill.id);},
        ),
      ),
    );
  }
}