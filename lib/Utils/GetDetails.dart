import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:societymanagement/Utils/GetSharedPref.dart';

var now = new DateTime.now();
var formatter = new DateFormat('yyyy-MM-dd');
String date = formatter.format(now);

bool isAdmin = false;
String name, flat, society, address, secretary, soccode, phone, phoneno;
List title = List(), subtitle = List();
// List complainttitle = List(), complaintsubtitle = List(), complainee = List(), complaineeflat = List();
List contactflat = List(), contactname = List(), contactphone = List();
CollectionReference collectionReference = FirebaseFirestore.instance.collection(soccodesp);

getData() async {
  if(phoneno == phonesp) isAdmin = true;
  else isAdmin = false;

  final memberdata = await collectionReference.doc(phonesp).get();
  name = memberdata.data()['name'];
  flat = memberdata.data()['flatno'];
  phone = memberdata.id;

  final admindata = await collectionReference.doc("Admin").get();
  society = admindata.data()['society'];
  address = admindata.data()['address'];
  secretary = admindata.data()['secretary'];
  phoneno = admindata.data()['phone'];
  soccode = admindata.data()['soccode'];

  // final noticelist = await collectionReference.doc("Notice").collection(date).get();
  // noticelist.docs.forEach((document) {
  //   title.add(document.data()['title']);
  //   subtitle.add(document.data()['subtitle']);
  // });

  // final complaintlist = await collectionReference.doc("Complaint").collection(date).get();
  // complaintlist.docs.forEach((document) {
  //   complainttitle.add(document.data()['complainttitle']);
  //   complaintsubtitle.add(document.data()['complaintsubtitle']);
  //   complainee.add(document.data()['complainee']);
  //   complaineeflat.add(document.data()['complaineeflat']);
  // });

  final contacts = await collectionReference.get();
  contacts.docs.forEach((document) {
    if(document.id == "Admin") {
      return;
    } else if(document.id == "Notice") {
      return;
    } else if(document.id == "Bill") {
      return;
    } else {
      contactname.add(document.data()['name']);
      contactflat.add(document.data()['flatno']);
      contactphone.add(document.id);
    }
  });

  title = title.toSet().toList();
  subtitle = subtitle.toSet().toList();
  
  // complainttitle = complainttitle.toSet().toList();
  // complaintsubtitle = complaintsubtitle.toSet().toList();
  // complainee = complainee.toSet().toList();
  // complaineeflat = complaineeflat.toSet().toList();

  contactname = contactname.toSet().toList();
  contactflat = contactflat.toSet().toList();
  contactphone = contactphone.toSet().toList();
}