import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gamershub/Screens/wallet.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:intl/intl.dart';

class AddAmountPage extends StatefulWidget {
  @override
  _AddAmountPageState createState() => _AddAmountPageState();
}
class Actor {
  const Actor(this.title);
  final String title;
}
class _AddAmountPageState extends State<AddAmountPage> {
        final List<Actor> _cast = <Actor>[
    const Actor("Currently We are not accepting wallet payments"),
  ];

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  Razorpay _razorpay;
  String email;
  String phone;
  String pubg;
  String name;
  int winningAmount;
  List transactions = [];
  int depositedAmount;
  int enteredAmount = 0;
  Future<void> _fetchUserAmountData() async {
    User _currentUser = FirebaseAuth.instance.currentUser;
    String authid = _currentUser.uid;
    await FirebaseFirestore.instance
        .collection('UserData')
        .doc('$authid')
        .get()
        .then((ds) {
      if (ds.exists) {
        email = ds.data["Email"];
        phone = ds.data["MobileNum"];
      }
    });
    print(email + " " + phone);
    await FirebaseFirestore.instance
        .collection('UserTransactions')
        .doc('$authid')
        .get()
        .then((dss) {
      if (dss.exists) {
        depositedAmount = dss.data["DepositAmount"];
        name = dss.data["FullName"];
        winningAmount = dss.data["WinningAmount"];
        transactions = dss.data["transactions"];
        pubg = dss.data["PubgId"];
      }
    });
  }

  @override
  void initState() {
    super.initState();
    _fetchUserAmountData();
    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }

  @override
  void dispose() {
    super.dispose();
    _razorpay.clear();
  }

  void openCheckout(int amount) async {
    var options = {
      'key': 'rzp_live_I2Huy3ON1yMwOn',
      'amount': amount * 100,
      'name': 'Battle Warriors',
      'description': 'Adding Money in the Wallet',
      'prefill': {'contact': phone, 'email': email},
      'external': {
        'wallets': ['paytm'],
      }
    };
    try {
      _razorpay.open(options);
    } catch (e) {
      debugPrint(e);
    }
  }

  Future<void> _saveTransaction(paymentId) async {
    FirebaseUser user = await FirebaseAuth.instance.currentUser();
    String userId = user.uid;
    print("Userid" + userId);
    final DocumentReference dbr =
        Firestore.instance.document("UserTransactions/$userId");
    var now = new DateTime.now();
    var formatter = new DateFormat('yyyy-MM-dd');
    String formattedDate = formatter.format(now);
    print(formattedDate);
    String time = new DateFormat("H:m:s").format(now);
    Map<String, dynamic> transferData = {
      "Transfer": "IN",
      "Date": formattedDate,
      "Time": time,
      "Amount": enteredAmount,
      "AccountWallet": enteredAmount,
      "WinningWallet": "NULL",
      "Mode": "BALANCE",
      "Type": "NULL",
      "Rank": "NULL",
      "Kill": "NULL",
      "PaymentId": paymentId,
    };
    transactions.add(transferData);
    print("Entered Amount" + enteredAmount.toString());
    print("Deposited AMount " + depositedAmount.toString());
    Map<String, dynamic> userData = <String, dynamic>{
      'AuthUserId': '$userId',
      'Email': '$email',
      'WinningAmount': winningAmount,
      'DepositAmount': enteredAmount + depositedAmount,
      'FullName': '$name',
      'PubgId': pubg,
      'transactions': transactions,
    };
    print(userData);
    setState(() {
      dbr.updateData(userData).then((value) => {
            Fluttertoast.showToast(msg: 'Success  ' + paymentId),
          });
    });
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) async {
    String paymentId = response.paymentId;
    await _saveTransaction(paymentId).then((value) => {
          Navigator.pop(context, ),
         Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_) {
           return WalletPage();
         }))
        });
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    Fluttertoast.showToast(
        msg: 'Failure  ' + response.code.toString() + " - " + response.message);
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    Fluttertoast.showToast(
        msg: 'Currently we are not accepting wallet payment' +
            response.walletName);
  }
      Iterable<Widget> get actorWidgets sync* {
    for (final Actor actor in _cast) {
      yield Padding(
        padding: const EdgeInsets.all(4.0),
        child: Chip(
          label: Text(actor.title, style: TextStyle(fontFamily: "Quicksand", ),),
          onDeleted: () {
            setState(() {
              _cast.removeWhere((Actor entry) {
                return entry.title == actor.title;
              });
            });
          },
        ),
      );
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text("Add Amount", style: TextStyle(fontFamily: "Quicksand",),), backgroundColor: Colors.blueGrey.shade800),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
                                         Wrap(
                   children: actorWidgets.toList(),
                 ),
            Padding(
              padding: const EdgeInsets.only(left: 14.0, right: 14.0, top: 20),
              child: Container(
                alignment: Alignment.centerLeft,
                decoration: BoxDecoration(
                  color: Colors.blueGrey.shade100,
                  borderRadius: BorderRadius.circular(10.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 6.0,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                height: 60.0,
                child: Form(
                  key: _formKey,
                  child: TextFormField(
                    onChanged: (value) async {
                      setState(() {
                        int e = int.parse(value);
                        enteredAmount = e;
                      });
                    },
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Please Enter the Amount';
                      }
                      return null;
                    },
                    cursorColor: Colors.black,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.only(top: 15),
                      hintText: "Amount...",
                      border: InputBorder.none,
                      prefixIcon: Icon(
                        Icons.account_balance,
                        color: Colors.black,
                      ),
                    ),
                    style: TextStyle(
                      color: Colors.black,
                      fontFamily: "Quicksand",
                    ),
                  ),
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.all(20),
              width: double.infinity,
              child: RaisedButton(
                color: Colors.blueGrey.shade800,
                onPressed: () async {
                  if (_formKey.currentState.validate()) {
                    print(enteredAmount);
                    openCheckout(enteredAmount);
                  }
                },
                elevation: 10.0,
                padding: EdgeInsets.all(15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Text(
                  "Add Amount",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    fontFamily: "Quicksand",
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
