import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:societymanagement/Components/RaisedBtn.dart';
import 'package:societymanagement/Components/TextField.dart';

class Payment extends StatefulWidget {
  @override
  _PaymentState createState() => _PaymentState();
}

class _PaymentState extends State<Payment> {
  double amount;
  FocusNode paymentFN = FocusNode();
  Razorpay _razorpay;

  @override
  void initState() {
    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              kTextField("Enter Amount", Icon(Icons.payment), paymentFN, TextInputType.number, (value){amount = value;}),
              kRaisedButton(MediaQuery.of(context).size.width*0.3, "Pay Now", (){proceedPayment();}),
            ],
          ),
        ),
      ),
    );
  }

  void proceedPayment() async {
    var options = {
      'key': 'rzp_test_KmWY8V0p2QgPJQ',
      'amount': amount ?? 0,
      'name': 'Hello Society',
      'description': 'Pay Soceity Funds',
      'prefill': {'contact': '', 'email': ''},
      'external': {
        'wallets': ['paytm']
      }
    };

    try {
      _razorpay.open(options);
    } catch (e) {
      debugPrint(e);
    }
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    Fluttertoast.showToast(msg: "SUCCESS: " + response.paymentId);
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    Fluttertoast.showToast(msg: "ERROR: " + response.code.toString() + " - " + response.message);
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    Fluttertoast.showToast(msg: "EXTERNAL_WALLET: " + response.walletName);
  }
}

// void _handlePaymentSuccess(PaymentSuccessResponse response)  async {
//     setState(() {
//       ci = true;
//     });
//     await UpdatePayment();
//     Navigator.pop(context);
//     Fluttertoast.showToast(
//         msg: "SUCCESS: " + response.paymentId,);

//   }



//   Future<String> getData(int index) async {
//     QuerySnapshot querySnapshot = await _firestore.collection("Payments").getDocuments();
//    // print(querySnapshot.documents[index].documentID);
//     return querySnapshot.documents[index].documentID;

//   }


//   Future UpdatePayment() async{
//      String s = await getData(widget.accountindex);
//      print(s);
//     await _firestore.runTransaction((transaction)async{
//       DocumentReference documentReference = _firestore.collection('Payments')
//           .document(s);
//       DocumentSnapshot snapshot = await transaction.get(documentReference);
//       int oldamount = snapshot.data['duePayment'];
//       int  diff = oldamount - amount;

//       await transaction.update(documentReference,{
//         'duePayment' : diff,

//       });

//     });

//   }


///////////////////////////////////
  // Future<int> getData(int index) async {
  //   QuerySnapshot querySnapshot = await _firestore.collection("Payments").getDocuments();
  //   /*This Code is just for problem statement for a single user without registration module Thats why the Hash of the email is hardcoded , With Registration Module The email can be taken
  //   * dynamically for all the user available in the database */
  //   print("DOremon");
  //   print(querySnapshot.documents[index].data["duePayment"]);
  //  return querySnapshot.documents[index].data["duePayment"];
    
  // }