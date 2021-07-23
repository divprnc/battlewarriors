import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:gamershub/Screens/account_data.dart';
import 'package:gamershub/Screens/change_passord.dart';
import 'package:gamershub/Screens/mobile_edit.dart';

class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  bool isLoading = false;
  bool allAccountController;
  Future<void> getaccountControl() async {
    setState(() {
      isLoading = true;
    });
    await Firestore.instance
        .collection('UserAccountControl')
        .document('Account')
        .get()
        .then((dss) {
      if (dss.exists) {
        allAccountController = dss.data["Settings"];
      }
    });
        setState(() {
      isLoading = false;
    });
  }

  @override
  void initState(){
    super.initState();
    getaccountControl();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
          title: Text("Settings", style: TextStyle(fontFamily: "Quicksand",),), backgroundColor: Colors.blueGrey.shade800),
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
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.of(context)
                            .push(MaterialPageRoute(builder: (_) {
                          return ChangePassword();
                        }));
                      },
                      child: Container(
                        alignment: Alignment.centerLeft,
                        decoration: BoxDecoration(
                          color: Colors.blueGrey.shade200,
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
                        child: ListTile(
                          title: Text(
                            "Change Password",
                            style: TextStyle(color: Colors.black, fontSize: 20,fontFamily: "Quicksand",),
                          ),
                          leading: Icon(
                            Icons.lock,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.of(context)
                            .push(MaterialPageRoute(builder: (_) {
                          return EditMobileNumber();
                        }));
                      },
                                          child: Container(
                        alignment: Alignment.centerLeft,
                        decoration: BoxDecoration(
                          color: Colors.blueGrey.shade200,
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
                        child: ListTile(
                          title: Text(
                            "Mobile Number",
                            style: TextStyle(color: Colors.black, fontSize: 20,fontFamily: "Quicksand",),
                          ),
                          leading: Icon(
                            Icons.phone_android,
                            color: Colors.black,
                          ),
                          trailing: GestureDetector(
                            onTap: () {
                              _scaffoldKey.currentState.showSnackBar(SnackBar(
                                backgroundColor: Colors.blueGrey.shade800,
                                content: allAccountController == true ?Text(
                                  'Make sure it is your paytm number to receive your payments, once you have edited you cannot change it.',
                                  style: TextStyle(
                                    fontSize: 15,fontFamily: "Quicksand",
                                    color: Colors.white,
                                  ),
                                ):Text(
                                  'Make sure it is a Indian Mobile Number.',
                                  style: TextStyle(
                                    fontSize: 15,fontFamily: "Quicksand",
                                    color: Colors.white,
                                  ),
                                ) ,
                                duration: Duration(seconds: 3),
                              ));
                            },
                            child: Icon(Icons.info),
                          ),
                        ),
                      ),
                    ),
                  ),
                  allAccountController == true ?Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.of(context)
                            .push(MaterialPageRoute(builder: (_) {
                          return EditAccountData();
                        }));
                      },
                                          child: Container(
                        alignment: Alignment.centerLeft,
                        decoration: BoxDecoration(
                          color: Colors.blueGrey.shade200,
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
                        child: ListTile(
                          title: Text(
                            "Account Details",
                            style: TextStyle(color: Colors.black, fontSize: 20,fontFamily: "Quicksand",),
                          ),
                          leading: Icon(
                            Icons.account_balance,
                            color: Colors.black,
                          ),
                          trailing: GestureDetector(
                            onTap: () {
                              _scaffoldKey.currentState.showSnackBar(SnackBar(
                                backgroundColor: Colors.blueGrey.shade800,
                                content: Text(
                                  'Please Fill your account details to receive payments in your bank account',
                                  style: TextStyle(
                                    fontSize: 15,fontFamily: "Quicksand",
                                    color: Colors.white,
                                  ),
                                ),
                                duration: Duration(seconds: 3),
                              ));
                            },
                            child: Icon(Icons.info),
                          ),
                        ),
                      ),
                    ),
                  ) : Container(),
                ],
              ),
            ),
    );
  }
}
