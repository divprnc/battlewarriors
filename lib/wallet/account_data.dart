import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';

class EditAccountData extends StatefulWidget {
  @override
  _EditAccountDataState createState() => _EditAccountDataState();
}

class _EditAccountDataState extends State<EditAccountData> {


  String accountNumber;
  TextEditingController accountNumberData;
  String ifscCode;
  TextEditingController ifscdata;
  String accountHolder;
  TextEditingController holderdata;
  bool isLoading = false;
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String mobile;
  TextEditingController mobilenum;

    Future<void> getUserData() async {
    FirebaseUser _currentUser = await FirebaseAuth.instance.currentUser();
    String authid = _currentUser.uid;
    setState(() {
      isLoading = true;
    });
    await Firestore.instance
        .collection('UserData')
        .document('$authid')
        .get()
        .then((ds) => {
             accountNumber = ds.data["AccountData"]["AccountNumber"],
             accountNumberData = TextEditingController(text: '$accountNumber'),
             ifscCode = ds.data["AccountData"]["IFSC"],
             ifscdata = TextEditingController(text: '$ifscCode'),
             accountHolder = ds.data["AccountData"]["AccountOwnerName"],
             holderdata = TextEditingController(text: '$accountHolder'),
            });
    setState(() {
      isLoading = false;
    });
  }
  
    @override
  void initState() {
    super.initState();
    getUserData();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
       appBar: AppBar(
          title: Text("Account Data", style: TextStyle(fontFamily: "Quicksand",),), backgroundColor: Colors.blueGrey.shade800,
        ),
        body: isLoading
          ? Center(
              child: SpinKitCircle(
                color: Colors.blueGrey.shade900,
                size: 50.0,
              ),
            )
          : Column(children: [

             Form(
               key: _formKey,
               child: Column(
                 children: [
                   Padding(
                     padding: const EdgeInsets.all(8.0),
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
                       child: TextFormField(
                         onChanged: (value) {
                           setState(() {
                             accountNumber = value;
                           });
                         },
                         validator: (value) {
                           if (value.isEmpty) {
                             return 'Please Enter your account number';
                           }
                           return null;
                         },
                         keyboardType: TextInputType.number,
                         controller: accountNumberData,
                         cursorColor: Colors.black,
                         decoration: InputDecoration(
                           contentPadding: EdgeInsets.only(top: 15),
                           hintText: "Account Number",
                           border: InputBorder.none,
                           prefixIcon: Icon(
                             Icons.lock_outline,
                             color: Colors.black,
                           ),
                         ),
                         style: TextStyle(
                           color: Colors.black,
                           fontFamily: "Quicksand"
                         ),
                       ),
                     ),
                   ),
            Padding(
              padding: const EdgeInsets.all(8.0),
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
                child: TextFormField(
                  onChanged: (value) {
                    setState(() {
                      ifscCode = value;
                    });
                  },
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Enter your IFSC code of your account number';
                    }
                    return null;
                  },
                  keyboardType: TextInputType.text,
                  controller: ifscdata,
                  cursorColor: Colors.black,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.only(top: 15),
                    hintText: "IFSC Code",
                    border: InputBorder.none,
                    prefixIcon: Icon(
                      Icons.lock,
                      color: Colors.black,
                    ),
                  ),
                  style: TextStyle(
                    color: Colors.black,
                    fontFamily: "Quicksand"
                  ),
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(8.0),
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
                child: TextFormField(
                  onChanged: (value) {
                    setState(() {
                      accountHolder = value;
                    });
                  },
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Enter Account Holder Name';
                    }
                    return null;
                  },
                  keyboardType: TextInputType.text,
                  controller: holderdata,
                  cursorColor: Colors.black,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.only(top: 15),
                    hintText: "Account Holder Name",
                    border: InputBorder.none,
                    prefixIcon: Icon(
                      Icons.lock,
                      color: Colors.black,
                    ),
                  ),
                  style: TextStyle(
                    color: Colors.black,
                    fontFamily: "Quicksand"
                  ),
                ),
              ),
            ),
                 ],
               ),
             ),
            Container(
              padding: EdgeInsets.all(20),
              width: double.infinity,
              child: RaisedButton(
                color: Colors.blueGrey.shade800,
                onPressed: () async {
                  if(_formKey.currentState.validate()) {
                    await updateAccount(accountNumber, ifscCode, accountHolder);
                  }
                },
                elevation: 10.0,
                padding: EdgeInsets.all(15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Text(
                  "Update",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    fontFamily: "Quicksand"
                  ),
                ),
              ),
            ),
          ],)
    );
  }

  Future<void> updateAccount(accountNumber, ifscCode, accountHolder) async {
    setState(() {
      isLoading = true;
    });
         FirebaseUser _currentUser = await FirebaseAuth.instance.currentUser();
     String authid = _currentUser.uid;
     final DocumentReference databaseReference =
          Firestore.instance.document("UserData/$authid");
     databaseReference
          .updateData({
              "AccountData" : {
                "AccountNumber": accountNumber,
                "IFSC": ifscCode,
                "AccountOwnerName": accountHolder,
              }
          })
          .then((value) => {Fluttertoast.showToast(msg: "Mobile Number Updated", )});     

    setState(() {
      isLoading = false;
    });
  }

}