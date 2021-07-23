import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ProfileEdit extends StatefulWidget {
  @override
  _ProfileEditState createState() => _ProfileEditState();
}

class _ProfileEditState extends State<ProfileEdit> {
  bool isLoading = false;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  String getpubg;
  String name;
  TextEditingController nameData;
  String email;
  TextEditingController emailData;
  String pubgid;
  TextEditingController pubgData;
  String mobile;
  TextEditingController mobileData;
  String state;
  TextEditingController stateData;
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
        allAccountController = dss.data["Profile"];
      }
    });
        setState(() {
      isLoading = false;
    });
  }


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
              name = ds.data['FullName'],
              nameData = TextEditingController(text: '$name'),
              email = ds.data['Email'],
              emailData = TextEditingController(text: '$email'),
              pubgid = ds.data['PubgId'],
              pubgData = TextEditingController(text: '$pubgid'),
              mobile = "+91-" + ds.data['MobileNum'],
              mobileData = TextEditingController(text: '$mobile'),
              state = ds.data['State'],
              stateData = TextEditingController(text: '$state'),
            });
    setState(() {
      isLoading = false;
    });
  }

  bool enabled() {
    bool val;
    setState(() {
      if (pubgid == "" || pubgid == "null" || pubgid == null) {
        val = true;
      } else {
        val = false;
      }
    });

    return val;
  }

  Future<void> _updateUserData() async {
    setState(() {
      isLoading = true;
    });
    try {
      FirebaseUser _currentUser = await FirebaseAuth.instance.currentUser();
      String authid = _currentUser.uid;
      final DocumentReference databaseReference =
          Firestore.instance.document("UserData/$authid");
      final DocumentReference dbcompleted =
          Firestore.instance.document("UserCompletedGame/$authid");
      final DocumentReference dbJoined =
          Firestore.instance.document("UserJoinedGame/$authid");
      final DocumentReference dbtransaction =
          Firestore.instance.document("UserTransactions/$authid");
      Map<String, String> userData = <String, String>{
        'State': '$state',
      };


      await Firestore.instance
          .collection('UserTransactions')
          .document('$authid')
          .get()
          .then((ds) => {
                if (ds.exists)
                  {
                    if (ds.data["PubgId"] == "" || pubgid == "null" || pubgid == null)
                      {
                        print(getpubg),
                        dbJoined.updateData({
                          "PubgId": getpubg
                        }),
                        dbtransaction.updateData({
                          "PubgId": getpubg
                        }),
                        dbcompleted.updateData({
                          "PubgId": getpubg
                        }),
                        databaseReference.updateData({
                          "PubgId": getpubg
                        }),
                      }
                  }
              });

      databaseReference
          .updateData(userData)
          .then((value) => {Fluttertoast.showToast(msg: "Profile Updated")});
    } 
    catch (e) {
      print("Error -> " + e);
    }
    // Navigator.of(context).pop();
    setState(() {
      pubgid = "gamershub";
      isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    getUserData();
    getaccountControl();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text("Edit Profile", style: TextStyle(fontFamily: "Quicksand",),),
        backgroundColor: Colors.blueGrey.shade900,
      ),
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
                  Container(
                    width: MediaQuery.of(context).size.width,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          width: 140,
                          height: 140,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                              image:
                                  ExactAssetImage('assets/images/profile.jpg'),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 10),
                          child: Container(
                            child: Text(
                              'Personal Information',
                              style: TextStyle(fontFamily: "Quicksand",
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                        Form(
                          child: Column(
                            children: <Widget>[
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
                                    controller: nameData,
                                    onChanged: (value) {
                                      setState(() {
                                        name = value;
                                      });
                                    },
                                    cursorColor: Colors.black,
                                    enabled: false,
                                    decoration: InputDecoration(
                                      contentPadding: EdgeInsets.only(top: 15),
                                      hintText: "Your Name...",
                                      border: InputBorder.none,
                                      prefixIcon: Icon(
                                        Icons.description,
                                        color: Colors.black,
                                      ),
                                    ),
                                    style: TextStyle(
                                      color: Colors.black,fontFamily: "Quicksand",
                                    ),
                                  ),
                                ),
                              ),
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
                                    onChanged: (value) {
                                      setState(() {
                                        email = value;
                                      });
                                    },
                                    cursorColor: Colors.black,
                                    controller: emailData,
                                    enabled: false,
                                    decoration: InputDecoration(
                                      contentPadding: EdgeInsets.only(top: 15),
                                      hintText: "Your Email...",
                                      border: InputBorder.none,
                                      prefixIcon: Icon(
                                        Icons.email,
                                        color: Colors.black,
                                      ),
                                    ),
                                    style: TextStyle(
                                      color: Colors.black,fontFamily: "Quicksand",
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(14.0),
                                child: Stack(
                                  children: [
                                    Container(
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
                                            mobile = value;
                                          });
                                        },
                                        cursorColor: Colors.black,
                                        controller: mobileData,
                                        decoration: InputDecoration(
                                          contentPadding: EdgeInsets.only(top: 15),
                                          hintText: "Mobile Number..",
                                        enabled: false,
                                          border: InputBorder.none,
                                          prefixIcon: Icon(
                                            Icons.call,
                                            color: Colors.black,
                                          ),
                                        ),
                                        style: TextStyle(
                                          color: Colors.black,fontFamily: "Quicksand",
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                      left: MediaQuery.of(context).size.width * 0.85,
                                      bottom: 1.5,
                                      top: 2.3,
                                      child: GestureDetector(
                                        onTap: () {
                                          _scaffoldKey.currentState
                                        .showSnackBar(SnackBar(
                                      backgroundColor: Colors.blueGrey.shade800,
                                      content: allAccountController == true ? Text(
                                        'This is your mobile number, you can change it from settings. Make sure it is your paytm number to receive your payments',
                                        style: TextStyle(
                                          fontSize: 15,
                                          color: Colors.white, fontFamily: "Quicksand",
                                        ),
                                      ):Text(
                                        'This is your mobile number, you can change it from settings. ',
                                        style: TextStyle(
                                          fontSize: 15,
                                          color: Colors.white, fontFamily: "Quicksand",
                                        ),
                                      ),
                                      duration: Duration(seconds: 3),
                                    ));
                                        },
                                        child: Icon(Icons.info)),
                                    ),
                                  ],
                                ),
                              ),
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
                                    onChanged: (val) {
                                      setState(() {
                                        getpubg = val;
                                      });
                                    },
                                    cursorColor: Colors.black,
                                    controller: pubgData,
                                    enabled: enabled(),
                                    decoration: InputDecoration(
                                      contentPadding: EdgeInsets.only(top: 15),
                                      hintText: "Pubg Username",
                                      border: InputBorder.none,
                                      prefixIcon: Icon(
                                        Icons.all_inclusive,
                                        color: Colors.black,
                                      ),
                                    ),
                                    style: TextStyle(
                                      color: Colors.black,fontFamily: "Quicksand",
                                    ),
                                  ),
                                ),
                              ),
                              
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
                                    onChanged: (value) {
                                      setState(() {
                                        state = value;
                                      });
                                    },
                                    cursorColor: Colors.black,
                                    controller: stateData,
                                    decoration: InputDecoration(
                                      contentPadding: EdgeInsets.only(top: 15),
                                      hintText: "State",
                                      border: InputBorder.none,
                                      prefixIcon: Icon(
                                        Icons.location_city,
                                        color: Colors.black,
                                      ),
                                    ),
                                    style: TextStyle(
                                      color: Colors.black,fontFamily: "Quicksand",
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
                                    await _updateUserData();
                                  },
                                  elevation: 10.0,
                                  padding: EdgeInsets.all(15),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                  child: Text(
                                    "Update Profile",
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
                      ],
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
