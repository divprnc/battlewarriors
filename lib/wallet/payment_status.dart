import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:gamershub/Screens/wallet.dart';

class PaymentStatus extends StatefulWidget {
  @override
  _PaymentStatusState createState() => _PaymentStatusState();
}

class _PaymentStatusState extends State<PaymentStatus> {
  String amount;
  bool isLoading = false;
  String phone;
  String accountnum;
  String ifsc;
  String holdername;
  Future<void> fetchUserAmountDatas() async {
    setState(() {
      isLoading = true;
    });
    FirebaseUser _currentUser = await FirebaseAuth.instance.currentUser();
    String authid = _currentUser.uid;
    await Firestore.instance
        .collection('PaymentProcessing')
        .document('$authid')
        .get()
        .then((dss) {
      if (dss.exists) {
        phone = dss.data["AccountData"]["PaytmNumber"];
        accountnum = dss.data["AccountData"]["AccountNumber"];
        ifsc = dss.data["AccountData"]["IFSC"];
        amount = dss.data["BalanceData"]["Amount"];
        holdername = dss.data["AccountData"]["AccountHolderName"];
      }
    });
    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    fetchUserAmountDatas();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text("Payment Status", style: TextStyle(fontFamily: "Quicksand",),),
          backgroundColor: Colors.blueGrey.shade900),
      body: WillPopScope(
        onWillPop: () {
          Navigator.of(context).pop();
          return Navigator.of(context)
              .pushReplacement(MaterialPageRoute(builder: (_) {
            return WalletPage();
          }));
          
        },
        child: isLoading
            ? Center(
                child: SpinKitCircle(
                  color: Colors.blueGrey.shade900,
                  size: 50.0,
                ),
              )
            : Container(
                width: double.infinity,
                height: MediaQuery.of(context).size.height,
                decoration: BoxDecoration(
                  color: Colors.blueGrey.shade900,
                ),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Image(
                          image: AssetImage(
                            'assets/images/13.gif',
                          ),
                          colorBlendMode: BlendMode.multiply,
                          color: Colors.blueGrey.shade900.withOpacity(1)),
                      Text(
                        "Your Payment Status",
                        style: TextStyle(color: Colors.white, fontSize: 30, fontFamily: "Quicksand", fontWeight: FontWeight.bold,),
                      ),
                      SizedBox(height: 5),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "We have received your payment request, Your payment will be processed and settled to your account details provided by you within 24 hours.",
                          style: TextStyle(color: Colors.white, fontSize: 15, fontFamily: "Quicksand", ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "Amount ₹ $amount" +
                              " will be deducted from your winning wallet, till then you will not be able to withdraw the money. Withdraw amount option will be opened after this transaction is sucessfull.",
                          style: TextStyle(color: Colors.white, fontSize: 15, fontFamily: "Quicksand", ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "Account Details",
                          style: TextStyle(color: Colors.white, fontSize: 15, fontFamily: "Quicksand", ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            phone == "" || phone == null || phone == "null"
                                ? Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            "Account Number",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 12, fontFamily: "Quicksand", ),
                                          ),
                                          Text(
                                            "$accountnum",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 12, fontFamily: "Quicksand", ),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            "IFSC Code",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 12, fontFamily: "Quicksand", ),
                                          ),
                                          Text(
                                            "$ifsc",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 12, fontFamily: "Quicksand", ),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            "Account Holder Name",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 12, fontFamily: "Quicksand", ),
                                          ),
                                          Text(
                                            "$holdername",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 12, fontFamily: "Quicksand", ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  )
                                : Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "Paytm Mobile Number",
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 12, fontFamily: "Quicksand", ),
                                      ),
                                      Text(
                                        "+91-$phone",
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 12, fontFamily: "Quicksand", ),
                                      ),
                                    ],
                                  ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
      ),
    );
  }
}
