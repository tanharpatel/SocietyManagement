import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:societymanagement/Components/CustomAppBar.dart';
import 'package:societymanagement/Components/RaisedBtn.dart';
import 'package:societymanagement/Components/TextField.dart';
import 'package:societymanagement/Utils/GetDetails.dart';

class Payment extends StatefulWidget {
  static final String id = "Payment";
  @override
  _PaymentState createState() => _PaymentState();
}

class _PaymentState extends State<Payment> {
  int amount;
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
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(56),
          child: appBar(context, "Payment"),
        ),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: Column(
              children: [
                kTextField(context, "Enter Amount to Pay...", Icon(Icons.monetization_on), paymentFN, null, TextInputType.number, (value){amount = int.parse(value);}, TextInputAction.done),
                kRaisedButton(MediaQuery.of(context).size.width*0.3, "Pay Now", (){proceedPayment();}),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void proceedPayment() async {
    var options = {
      'key': 'rzp_test_KmWY8V0p2QgPJQ',
      'amount': amount*100 ?? 0,
      'name': secretary,
      'description': 'Pay Soceity Funds',
      'prefill': {'contact': phoneno, 'email': "$society@gmail.com"},
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