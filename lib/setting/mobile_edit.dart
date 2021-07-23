import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';

class EditMobileNumber extends StatefulWidget {
  @override
  _EditMobileNumberState createState() => _EditMobileNumberState();
}

class _EditMobileNumberState extends State<EditMobileNumber> {
  String mobilenumber;
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
              mobile = ds.data['MobileNum'],
              mobilenum = TextEditingController(text: '$mobile'),
            });
    setState(() {
      isLoading = false;
    });
  }

    bool enabled() {
    bool val;
    setState(() {
      if (mobile == "" || mobile == "null" || mobile == null) {
        val = true;
      } else {
        val = false;
      }
    });

    return val;
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
          title: Text("Mobile Number", style: TextStyle(fontFamily: "Quicksand",),), backgroundColor: Colors.blueGrey.shade800,
        ),
        body: isLoading
          ? Center(
              child: SpinKitCircle(
                color: Colors.blueGrey.shade900,
                size: 50.0,
              ),
            )
          : Column(
            children: [
             Form(
               key: _formKey,
               child: Column(
                 children: [
                   Padding(
              padding: const EdgeInsets.all(14.0),
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
                  controller: mobilenum,
                  enabled: enabled(),
                  onChanged: (value) {
                    setState(() {
                      mobilenumber = value;
                    });
                  },
                  validator: (value) {
                    if (value.length != 10) {
                      return 'Enter the correct mobile number';
                    }
                    return null;
                  },
                  keyboardType: TextInputType.number,
                  cursorColor: Colors.black,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.only(top: 15),
                    hintText: "Mobile Number",
                    border: InputBorder.none,
                    prefixIcon: Icon(
                      Icons.phone_android,
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
                    updatePhone(mobilenumber);
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
                     fontFamily: "Quicksand", 
                  ),
                ),
              ),
            ),
            ],
          )
    );
  }

  Future<void> updatePhone(String phonenum) async {
    setState(() {
      isLoading = true;
    });
     FirebaseUser _currentUser = await FirebaseAuth.instance.currentUser();
     String authid = _currentUser.uid;
     final DocumentReference databaseReference =
          Firestore.instance.document("UserData/$authid");
     databaseReference
          .updateData({
              'MobileNum' : phonenum,
          })
          .then((value) => {Fluttertoast.showToast(msg: "Mobile Number Updated")});     

    setState(() {
      isLoading = false;
    });
  }
}