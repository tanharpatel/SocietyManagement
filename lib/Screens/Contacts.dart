import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:societymanagement/Components/ConnectivityCheck.dart';
import 'package:societymanagement/Components/ContactCard.dart';
import 'package:societymanagement/Components/CustomAppBar.dart';
import 'package:societymanagement/Utils/GetDetails.dart';

class Contacts extends StatefulWidget {
  static final String id = "Contacts";
  @override
  _ContactsState createState() => _ContactsState();
}

class _ContactsState extends State<Contacts> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(56),
          child: appBar(context, "Contacts"),
        ),
        // body: ConnectivityCheck(
        //   childView: FutureBuilder(
        //     future: getData(),
        //     builder: (context, snapshot) {
        //       if(snapshot.connectionState == ConnectionState.waiting) {
        //         return Center(child: CircularProgressIndicator(),);
        //       } else if(snapshot == null) {
        //         return Center(child: Text("No Data Found!!"),);
        //       } else {
        //         return ListView.separated(
        //           separatorBuilder: (context, index) => SizedBox(height: 5,),
        //           itemCount: contactphone.length,
        //           itemBuilder: (context, index) {
        //             return contactCard(contactname[index], contactflat[index], contactphone[index]);
        //           },
        //         );
        //       }
        //     }
        //   ),
        // ),
        body: ConnectivityCheck(
          childView: StreamBuilder<QuerySnapshot>(
            stream: collectionReference.snapshots(),
            builder: (context, snapshot) {
              if(snapshot.connectionState == ConnectionState.waiting) {
                return CircularProgressIndicator();
              } else {
                if(snapshot.hasData) {
                  final contacts = snapshot.data.docs;
                  List<ContactCard> contactsCards = [];
                  for (var contact in contacts) {
                    final phone = contact.id;
                    final name = contact.data()['name'];
                    final flatno = contact.data()['flatno'];
                    final contactsCard = ContactCard(name: name, flat: flatno, phone: phone,);
                    if(contact.id != "Admin" && contact.id != "Notice" && contact.id != "Bill") {
                      contactsCards.add(contactsCard);
                    } else {}
                  }
                  return Expanded(child: ListView(children: contactsCards,));
                } else if(!snapshot.hasData) {
                  return Center(child: Text("No contacts Yet!!!"),);
                }
                return Container();
              }
            }
          ),
        ),
      ),
    );
  }
}