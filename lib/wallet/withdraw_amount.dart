import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:gamershub/Screens/account_data.dart';
import 'package:gamershub/Screens/mobile_edit.dart';
import 'package:gamershub/Screens/payment_status.dart';
import 'package:intl/intl.dart';

class WithdrawAmount extends StatefulWidget {
  @override
  _WithdrawAmountState createState() => _WithdrawAmountState();
}

class Actor {
  const Actor(this.title);
  final String title;
}

class _WithdrawAmountState extends State<WithdrawAmount> {
  final List<Actor> _cast = <Actor>[
    const Actor(
        "Please Fill the account Details of Paytm Number in the Settings"),
  ];
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool accountSelected = false;
  String amountwith;
  bool paymentSelected = false;
  String phone;
  String accountnum;
  String ifsc;
  String holdername;
  bool check;
  bool isLoading = false;
  int winningWalletBalance;
  List transactions = [];
  Future<void> fetchUserAmountDatas() async {
    setState(() {
      isLoading = true;
    });
    FirebaseUser _currentUser = await FirebaseAuth.instance.currentUser();
    String authid = _currentUser.uid;
    await Firestore.instance
        .collection('UserData')
        .document('$authid')
        .get()
        .then((dss) {
      if (dss.exists) {
        phone = dss.data["MobileNum"];
        accountnum = dss.data["AccountData"]["AccountNumber"];
        ifsc = dss.data["AccountData"]["IFSC"];
        holdername = dss.data["AccountData"]["AccountOwnerName"];
      }
    });
    setState(() {
      isLoading = false;
    });
  }

  Future<void> fetchAmountAndTransaction() async {
    setState(() {
      isLoading = true;
    });
    FirebaseUser _currentUser = await FirebaseAuth.instance.currentUser();
    String authid = _currentUser.uid;
    await Firestore.instance
        .collection('UserTransactions')
        .document('$authid')
        .get()
        .then((dss) {
      if (dss.exists) {
        winningWalletBalance = dss.data["WinningAmount"];
        transactions = dss.data["transactions"];
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
    fetchAmountAndTransaction();
  }

  Iterable<Widget> get actorWidgets sync* {
    for (final Actor actor in _cast) {
      yield Padding(
        padding: const EdgeInsets.all(4.0),
        child: Chip(
          label: Text(
            actor.title,
            style: TextStyle(
              fontFamily: "Quicksand",
            ),
          ),
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

  Future<void> updateTransactions() async {
    setState(() {
      isLoading = true;
    });
    FirebaseUser _currentUser = await FirebaseAuth.instance.currentUser();
    String authid = _currentUser.uid;
    int amounts = winningWalletBalance - int.parse(amountwith);
    var now = new DateTime.now();
    var formatter = new DateFormat('yyyy-MM-dd');
    String formattedDate = formatter.format(now);
    String time = new DateFormat("H:m:s").format(now);
    Map withdrawTransaction = {
      "Transfer": "OUT",
      "Date": formattedDate,
      "Time": time,
      "Amount": amountwith,
      "AccountWallet": "NULL",
      "WinningWallet": amountwith,
      "Mode": "BALANCE",
      "Type": "NULL",
      "Rank": "NULL",
      "Status": "Pending",
      "Kill": "NULL",
      "PaymentId": "",
    };
    transactions.add(withdrawTransaction);
    await Firestore.instance
        .collection("UserTransactions")
        .document(authid)
        .updateData({
      "WinningAmount": amounts,
      "transactions": transactions,
    }).then((value) => {print("Data Updated")});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(
            "Withdraw Amount",
            style: TextStyle(
              fontFamily: "Quicksand",
            ),
          ),
          backgroundColor: Colors.blueGrey.shade800),
      body: isLoading
          ? Center(
              child: SpinKitCircle(
                color: Colors.blueGrey.shade900,
                size: 50.0,
              ),
            )
          : SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  Wrap(
                    children: actorWidgets.toList(),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 14.0, right: 14.0, top: 20),
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
                              amountwith = value;
                            });
                          },
                          validator: (value) {
                            if (value.isEmpty) {
                              return '   Please Enter the Amount';
                            } else if (int.parse(value) < 30) {
                              return '   Minimum Amount should be 30';
                            } else if (int.parse(value) >
                                winningWalletBalance) {
                              return 'Amount is less than your Winning Wallet Balance';
                            }
                            return null;
                          },
                          cursorColor: Colors.black,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                              contentPadding: EdgeInsets.only(top: 15),
                              hintText: "Amount...",
                              border: InputBorder.none,
                              prefixIcon: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  "₹ ",
                                  style: TextStyle(
                                    fontSize: 30,
                                    fontFamily: "Quicksand",
                                  ),
                                ),
                              )),
                          style: TextStyle(
                            color: Colors.black,
                            fontFamily: "Quicksand",
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      InputChip(
                        label: Text(
                          'Account Number',
                          style: TextStyle(
                            color:
                                accountSelected ? Colors.white : Colors.black,
                            fontWeight: FontWeight.bold,
                            fontFamily: "Quicksand",
                          ),
                        ),
                        selected: accountSelected,
                        checkmarkColor: Colors.blueGrey.shade900,
                        selectedColor: Colors.orangeAccent,
                        onSelected: !accountSelected
                            ? (val) {
                                setState(() {
                                  accountSelected = true;
                                  paymentSelected = false;
                                });
                              }
                            : null,
                      ),
                      Text(
                        "Or",
                        style: TextStyle(
                          fontFamily: "Quicksand",
                        ),
                      ),
                      InputChip(
                        label: Text(
                          'Paytm Wallet',
                          style: TextStyle(
                            color:
                                paymentSelected ? Colors.white : Colors.black,
                            fontWeight: FontWeight.bold,
                            fontFamily: "Quicksand",
                          ),
                        ),
                        selected: paymentSelected,
                        checkmarkColor: Colors.blueGrey.shade900,
                        selectedColor: Colors.orange,
                        onSelected: !paymentSelected
                            ? (val) {
                                setState(() {
                                  paymentSelected = true;
                                  accountSelected = false;
                                });
                              }
                            : null,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    padding: EdgeInsets.all(20),
                    width: double.infinity,
                    child: RaisedButton(
                      color: Colors.blueGrey.shade800,
                      onPressed: () async {
                        if (_formKey.currentState.validate()) {
                          if (accountSelected == true) {
                            if (accountnum != "" ||
                                holdername != "" ||
                                ifsc != "") {
                              showModalBottomSheet(
                                  isScrollControlled: true,
                                  backgroundColor: Colors.orange.shade500,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(20),
                                    topRight: Radius.circular(20),
                                  )),
                                  context: context,
                                  builder: (context) {
                                    return FractionallySizedBox(
                                        heightFactor: 0.5,
                                        child: Container(
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.5,
                                          child: SingleChildScrollView(
                                            child: Column(
                                              children: [
                                                SizedBox(
                                                  height: 10,
                                                ),
                                                Text(
                                                  "Withdraw Amount Confirmation",
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    fontFamily: "Quicksand",
                                                    fontSize: 18,
                                                  ),
                                                ),
                                                Divider(
                                                  color: Colors.white,
                                                  thickness: 1,
                                                ),
                                                SizedBox(
                                                  height: 10,
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceAround,
                                                  children: [
                                                    Text(
                                                      "Amount to be withdrawn ",
                                                      style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 18,
                                                        fontFamily: "Quicksand",
                                                      ),
                                                    ),
                                                    Text(
                                                      "₹ " +
                                                          amountwith.toString(),
                                                      style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 18,
                                                        fontFamily: "Quicksand",
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      height: 10,
                                                    ),
                                                  ],
                                                ),
                                                SizedBox(
                                                  height: 30,
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Column(
                                                    children: [
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          Text(
                                                            "Account Number ",
                                                            style: TextStyle(
                                                              color:
                                                                  Colors.white,
                                                              fontSize: 18,
                                                              fontFamily:
                                                                  "Quicksand",
                                                            ),
                                                          ),
                                                          Text(
                                                            accountnum
                                                                .toString(),
                                                            style: TextStyle(
                                                              color:
                                                                  Colors.white,
                                                              fontSize: 18,
                                                              fontFamily:
                                                                  "Quicksand",
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          Text(
                                                            "IFSC Code ",
                                                            style: TextStyle(
                                                              color:
                                                                  Colors.white,
                                                              fontSize: 18,
                                                              fontFamily:
                                                                  "Quicksand",
                                                            ),
                                                          ),
                                                          Text(
                                                            ifsc.toString(),
                                                            style: TextStyle(
                                                              color:
                                                                  Colors.white,
                                                              fontSize: 18,
                                                              fontFamily:
                                                                  "Quicksand",
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          Text(
                                                            "Account Holder Name ",
                                                            style: TextStyle(
                                                              color:
                                                                  Colors.white,
                                                              fontSize: 18,
                                                              fontFamily:
                                                                  "Quicksand",
                                                            ),
                                                          ),
                                                          Text(
                                                            holdername
                                                                .toString(),
                                                            style: TextStyle(
                                                              color:
                                                                  Colors.white,
                                                              fontSize: 18,
                                                              fontFamily:
                                                                  "Quicksand",
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 20,
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Text(
                                                    "Amount will be added to " +
                                                        accountnum.toString() +
                                                        " number within 24 hours",
                                                    style: TextStyle(
                                                      fontSize: 20,
                                                      fontFamily: "Quicksand",
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 30,
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                    left: 10,
                                                    right: 10,
                                                  ),
                                                  child: Container(
                                                    color: Colors
                                                        .blueGrey.shade900,
                                                    height:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .height *
                                                            0.09,
                                                    width:
                                                        MediaQuery.of(context)
                                                            .size
                                                            .width,
                                                    child: OutlineButton(
                                                      onPressed: () async {
                                                        Navigator.of(context)
                                                            .pop();
                                                        setState(() {
                                                          isLoading = true;
                                                        });
                                                        var now =
                                                            new DateTime.now();
                                                        var formatter =
                                                            new DateFormat(
                                                                'dd-MM-yyyy');
                                                        String formattedDate =
                                                            formatter
                                                                .format(now);
                                                        String time =
                                                            new DateFormat(
                                                                    "H:m:s")
                                                                .format(now);
                                                        FirebaseUser
                                                            _currentUser =
                                                            await FirebaseAuth
                                                                .instance
                                                                .currentUser();
                                                        String authid =
                                                            _currentUser.uid;

                                                        updateTransactions();
                                                        final DocumentReference
                                                            dbr = Firestore
                                                                .instance
                                                                .document(
                                                                    "PaymentProcessing/$authid");
                                                        dbr
                                                            .setData({
                                                              "AccountData": {
                                                                "AccountNumber":
                                                                    accountnum,
                                                                "IFSC": ifsc,
                                                                "AccountHolderName":
                                                                    holdername,
                                                              },
                                                              "BalanceData": {
                                                                "Amount":
                                                                    amountwith,
                                                                "Date":
                                                                    '$formattedDate',
                                                                "Time": '$time',
                                                              },
                                                              "Check": true,
                                                            })
                                                            .whenComplete(
                                                                () async {})
                                                            .catchError((e) {
                                                              print(e);
                                                            });

                                                        setState(() {
                                                          isLoading = false;
                                                        });
                                                        await Navigator.of(
                                                                context)
                                                            .pushReplacement(
                                                                MaterialPageRoute(
                                                                    builder:
                                                                        (_) {
                                                          return PaymentStatus();
                                                        }));
                                                      },
                                                      color: Colors
                                                          .blueGrey.shade800,
                                                      borderSide: BorderSide(
                                                          color: Colors.blueGrey
                                                              .shade800),
                                                      child: Text("Confirm",
                                                          style: TextStyle(
                                                            color: Colors.white,
                                                            fontFamily:
                                                                "Quicksand",
                                                          )),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ));
                                  });
                            } else {
                              showDialogBox("Account");
                            }
                          } else if (paymentSelected == true) {
                                if(phone != "") {
                                    showModalBottomSheet(
                                isScrollControlled: true,
                                backgroundColor: Colors.orange.shade500,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(20),
                                  topRight: Radius.circular(20),
                                )),
                                context: context,
                                builder: (context) {
                                  return FractionallySizedBox(
                                      heightFactor: 0.5,
                                      child: Container(
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.5,
                                        child: SingleChildScrollView(
                                          child: Column(
                                            children: [
                                              SizedBox(
                                                height: 10,
                                              ),
                                              Text(
                                                "Withdraw Amount Confirmation",
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 18,
                                                  fontFamily: "Quicksand",
                                                ),
                                              ),
                                              Divider(
                                                color: Colors.white,
                                                thickness: 1,
                                              ),
                                              SizedBox(
                                                height: 10,
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceAround,
                                                children: [
                                                  Text(
                                                    "Amount to be withdrawn ",
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                      fontFamily: "Quicksand",
                                                      fontSize: 18,
                                                    ),
                                                  ),
                                                  Text(
                                                    "₹ " +
                                                        amountwith.toString(),
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                      fontFamily: "Quicksand",
                                                      fontSize: 18,
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: 10,
                                                  ),
                                                ],
                                              ),
                                              SizedBox(
                                                height: 30,
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Column(
                                                  children: [
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Text(
                                                          "Paytm Number ",
                                                          style: TextStyle(
                                                            color: Colors.white,
                                                            fontFamily:
                                                                "Quicksand",
                                                            fontSize: 18,
                                                          ),
                                                        ),
                                                        Text(
                                                          phone.toString(),
                                                          style: TextStyle(
                                                            color: Colors.white,
                                                            fontFamily:
                                                                "Quicksand",
                                                            fontSize: 18,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    SizedBox(
                                                      height: 20,
                                                    ),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              8.0),
                                                      child: Text(
                                                        "Amount will be added to +91-" +
                                                            phone.toString() +
                                                            " paytm number in the wallet within 24 hours",
                                                        style: TextStyle(
                                                          fontSize: 20,
                                                          fontFamily:
                                                              "Quicksand",
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              SizedBox(
                                                height: 30,
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                  left: 10,
                                                  right: 10,
                                                ),
                                                child: Container(
                                                  color:
                                                      Colors.blueGrey.shade900,
                                                  height: MediaQuery.of(context)
                                                          .size
                                                          .height *
                                                      0.09,
                                                  width: MediaQuery.of(context)
                                                      .size
                                                      .width,
                                                  child: OutlineButton(
                                                    onPressed: () async {
                                                      Navigator.of(context)
                                                          .pop();
                                                      setState(() {
                                                        isLoading = true;
                                                      });
                                                      var now =
                                                          new DateTime.now();
                                                      var formatter =
                                                          new DateFormat(
                                                              'dd-MM-yyyy');
                                                      String formattedDate =
                                                          formatter.format(now);
                                                      String time =
                                                          new DateFormat(
                                                                  "H:m:s")
                                                              .format(now);
                                                      FirebaseUser
                                                          _currentUser =
                                                          await FirebaseAuth
                                                              .instance
                                                              .currentUser();
                                                      String authid =
                                                          _currentUser.uid;
                                                      updateTransactions();
                                                      final DocumentReference
                                                          dbr = Firestore
                                                              .instance
                                                              .document(
                                                                  "PaymentProcessing/$authid");
                                                      dbr.setData({
                                                        "AccountData": {
                                                          "PaytmNumber": phone,
                                                        },
                                                        "BalanceData": {
                                                          "Amount": amountwith,
                                                          "Date":
                                                              '$formattedDate',
                                                          "Time": '$time',
                                                        },
                                                        "Check": true,
                                                      }).whenComplete(() {
                                                        print("Document added");
                                                      }).catchError((e) {
                                                        print(e);
                                                      });
                                                      setState(() {
                                                        isLoading = false;
                                                      });
                                                      await Navigator.of(
                                                              context)
                                                          .pushReplacement(
                                                              MaterialPageRoute(
                                                                  builder: (_) {
                                                        return PaymentStatus();
                                                      }));
                                                    },
                                                    color: Colors
                                                        .blueGrey.shade800,
                                                    borderSide: BorderSide(
                                                        color: Colors
                                                            .blueGrey.shade800),
                                                    child: Text("Confirm",
                                                        style: TextStyle(
                                                          color: Colors.white,
                                                          fontFamily:
                                                              "Quicksand",
                                                        )),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ));
                                }
                                );
                                }else{
                                  showDialogBox("Paytm");
                                }
                          } else {
                            showDialog(
                                context: context,
                                builder: (context) => AlertDialog(
                                      title: Text(
                                        "Please select one of the payment options.",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontFamily: "Quicksand",
                                        ),
                                      ),
                                      backgroundColor: Colors.blueGrey.shade900,
                                      actions: [
                                        FlatButton(
                                            onPressed: () {
                                              Navigator.pop(context, false);
                                            },
                                            child: Text(
                                              "OK",
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontFamily: "Quicksand",
                                              ),
                                            )),
                                      ],
                                    ));
                          }
                        }
                      },
                      elevation: 10.0,
                      padding: EdgeInsets.all(15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Text(
                        "Withdraw Amount",
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

  void showDialogBox(String title) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.blueGrey.shade900,
        title: Text(
          "Please Fill " + title + " in the Settings",
          style: TextStyle(
            color: Colors.white,
            fontFamily: "Quicksand",
          ),
        ),
        actions: [
          FlatButton(
              onPressed: () {
                Navigator.pop(context, false);
              },
              child: Text(
                "Cancel",
                style: TextStyle(
                  color: Colors.white,
                  fontFamily: "Quicksand",
                  fontWeight: FontWeight.bold,
                ),
              )),
          FlatButton(
              onPressed: () {
                if (title == "Account") {
                  Navigator.of(context).push(MaterialPageRoute(builder: (_) {
                    return EditAccountData();
                  }));
                }
                if (title == "Paytm") {
                  Navigator.of(context).push(MaterialPageRoute(builder: (_) {
                    return EditMobileNumber();
                  }));
                }
              },
              child: Text(
                "Settings",
                style: TextStyle(
                  color: Colors.white,
                  fontFamily: "Quicksand",
                  fontWeight: FontWeight.bold,
                ),
              ))
        ],
      ),
    );
  }
}
